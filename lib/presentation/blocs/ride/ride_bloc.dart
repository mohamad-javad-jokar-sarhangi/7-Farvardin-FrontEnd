import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/data/repositories/ride_repository.dart';
import 'package:myfront/presentation/blocs/ride/ride_event.dart';
import 'package:myfront/presentation/blocs/ride/ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final RideRepository rideRepository;

  RideBloc({required this.rideRepository}) : super(RideInitial()) {
    // Passenger → create ride request
    on<CreateRideRequest>((event, emit) async {
      emit(RideLoading());
      try {
        await rideRepository.createRideRequest(
          pickup: event.pickup,
          destination: event.destination,
        );
        emit(RideRequestCreated());
      } catch (e) {
        emit(RideError(e.toString()));
      }
    });

    // Driver → get ride requests
    on<GetDriverRequests>((event, emit) async {
      emit(RideLoading());
      try {
        final requests = await rideRepository.getDriverRequests();
        emit(DriverRequestsLoaded(requests));
      } catch (e) {
        emit(RideError(e.toString()));
      }
    });

    // Driver → accept ride request
    on<AcceptRideRequest>((event, emit) async {
      emit(RideLoading());
      try {
        await rideRepository.acceptRideRequest(event.requestId);
        emit(RideAccepted());
      } catch (e) {
        emit(RideError(e.toString()));
      }
    });
  }
}
