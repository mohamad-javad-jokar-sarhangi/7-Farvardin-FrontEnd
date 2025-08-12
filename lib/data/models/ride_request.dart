import 'dart:convert';

class RideRequest {
  final int id;
  final String pickup;
  final String destination;
  final String passengerName;
  final String passengerPhone;

  RideRequest({
    required this.id,
    required this.pickup,
    required this.destination,
    required this.passengerName,
    required this.passengerPhone,
  });

  factory RideRequest.fromJson(Map<String, dynamic> json) {
    return RideRequest(
      id: json['id'],
      pickup: json['pickup'],
      destination: json['destination'],
      passengerName: json['passenger_name'],
      passengerPhone: json['passenger_phone'],
    );
  }

  static List<RideRequest> listFromRawJson(String str) {
    final decoded = json.decode(utf8.decode(str.codeUnits)) as List;
    return decoded.map((e) => RideRequest.fromJson(e)).toList();
  }
}
