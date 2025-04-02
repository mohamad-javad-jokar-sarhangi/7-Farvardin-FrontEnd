abstract class UserEvent {}

class AddUser extends UserEvent { // رویدادی برای افزودن کاربر
  final String name;
  final String phone;
  final String role;

  AddUser(this.name, this.phone, this.role);
}
