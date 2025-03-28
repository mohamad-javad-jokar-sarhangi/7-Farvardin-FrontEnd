import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  // ثبت نام کاربر جدید
  Future<void> addUser(String name, String phone ,String role) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8090/users/api_register/'), // آدرس صحیح برای ثبت کاربران
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "role": role,
      }),
    );
    if (response.statusCode != 201) { // بررسی وضعیت موفقیت ثبت نام
      throw Exception('Failed to add user. Code: ${response.statusCode}');
    }
  }
}
