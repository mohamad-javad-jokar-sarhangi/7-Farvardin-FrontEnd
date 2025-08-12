import 'package:equatable/equatable.dart';
import 'package:myfront/data/models/ride_request.dart';

abstract class RideState extends Equatable {
  const RideState();

  @override
  List<Object?> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

// Passenger
class RideRequestCreated extends RideState {}

// Driver
class DriverRequestsLoaded extends RideState {
  final List<RideRequest> requests;

  const DriverRequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

class RideAccepted extends RideState {}

class RideError extends RideState {
  final String error;

  const RideError(this.error);

  @override
  List<Object?> get props => [error];
}
