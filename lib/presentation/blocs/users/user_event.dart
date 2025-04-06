abstract class UserEvent {}

// for api first register
class AddUser extends UserEvent { // رویدادی برای افزودن کاربر
  final String name;
  final String phone;
  final String role;

  AddUser(this.name, this.phone, this.role);
}

// for api check registeration
class SendPhoneNumberEvent extends UserEvent {
  final String phoneNumber;

  SendPhoneNumberEvent(this.phoneNumber);
}