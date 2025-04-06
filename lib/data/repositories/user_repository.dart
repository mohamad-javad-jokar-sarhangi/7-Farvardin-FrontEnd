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

  Future<Map<String, String>> sendPhoneAndGetCredentials(String phone) async {
  try {
    // ارسال درخواست POST به API
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8090/users/api/is_user_pass/${phone}/'), // آدرس API
      headers: {
        "Content-Type": "application/json", // تعیین نوع محتوا
      },
      
    );

    // بررسی وضعیت پاسخ
    if (response.statusCode == 200) {
      // پاسخ JSON دریافت‌شده را به Map تبدیل کنید
      final Map<String, dynamic> data = jsonDecode(response.body);
      // استخراج نام کاربری و رمز عبور از پاسخ API
      final String name = data['name'];
      final String phone = data['phone'];
      final String role = data['role'];
      final String username = data['username'];
      final String password = data['password'];

      // برگرداندن داده‌ها به عنوان Map
      return {
        "name": name,
        "phone": phone,
        "role": role,
        "username": username,
        "password": password,
      };
    } else {
      throw Exception(
        'Failed to get credentials. Status Code: ${response.statusCode}, Body: ${response.body}',
      );
    }
  } catch (e) {
    throw Exception('Error occurred while contacting API: $e');
  }
}
}
