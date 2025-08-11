abstract class UserEvent {}

// for api first register
class AddUser extends UserEvent { // رویدادی برای افزودن کاربر
  final String name;
  final String phone;
  final String role;
  final String location;

  AddUser(this.name, this.phone, this.role, this.location);
}

// for api check registeration
class SendPhoneNumberEvent extends UserEvent {
  final String phoneNumber;

  SendPhoneNumberEvent(this.phoneNumber);
}

// api login by usernam password
class LoginUserEvent extends UserEvent {
  final String username;
  final String password;

  LoginUserEvent(this.username, this.password);
}
