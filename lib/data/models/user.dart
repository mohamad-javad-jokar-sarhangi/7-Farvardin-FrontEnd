class User {      
  final String name; // نام کاربر
  final String phone; // شماره تلفن کاربر
  final String role;
  User({
    required this.name,
    required this.phone,
    required this.role,
  });

  // متدی برای تبدیل JSON دریافتی از API به مدل User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
    );
  }

  // متدی برای تبدیل مدل User به JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'role' : role,
    };
  }
}
