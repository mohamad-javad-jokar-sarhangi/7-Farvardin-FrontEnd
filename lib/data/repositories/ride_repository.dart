import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfront/data/models/ride_request.dart';

class RideRepository {
  final String baseUrl = "http://127.0.0.1:8090";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> createRideRequest({
    required String pickup,
    required String destination,
  }) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/ride/api/passenger/requests/'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "pickup": pickup,
        "destination": destination,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('خطا در ایجاد درخواست: ${utf8.decode(response.bodyBytes)}');
    }
  }

  Future<List<RideRequest>> getDriverRequests() async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/ride/api/driver/requests/'),
      headers: {
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return RideRequest.listFromRawJson(response.body);
    } else {
      throw Exception('خطا در دریافت لیست درخواست‌ها: ${utf8.decode(response.bodyBytes)}');
    }
  }

  Future<void> acceptRideRequest(int requestId) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/ride/api/driver/requests/$requestId/accept/'),
      headers: {
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception('خطا در پذیرش درخواست: ${utf8.decode(response.bodyBytes)}');
    }
  }
}
