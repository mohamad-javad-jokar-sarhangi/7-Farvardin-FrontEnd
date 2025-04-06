// user_entity.dart
class UserEntity {
  final int id;
  final String name;
  final String phoneNumber;
  final String role;
  final bool isApproved;
  final String? username;
  final String? password;

  UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.isApproved,
    this.username,
    this.password,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      isApproved: json['is_approved'] ?? false, // کلید اصلاح شده و مقدار پیش‌فرض در صورت نبود
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
      'is_approved': isApproved, // کلید اصلاح شده برای سازگاری با بک‌اند احتمالی
      'username': username,
      'password': password,
    };
  }
}
