import 'package:equatable/equatable.dart';

abstract class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object?> get props => [];
}

// Passenger → ایجاد درخواست سفر
class CreateRideRequest extends RideEvent {
  final String pickup;
  final String destination;

  const CreateRideRequest(this.pickup, this.destination);

  @override
  List<Object?> get props => [pickup, destination];
}

// Driver → گرفتن لیست درخواست‌ها
class GetDriverRequests extends RideEvent {}

// Driver → پذیرش درخواست
class AcceptRideRequest extends RideEvent {
  final int requestId;

  const AcceptRideRequest(this.requestId);

  @override
  List<Object?> get props => [requestId];
}
