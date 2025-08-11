abstract class UserState {}

class UserInitial extends UserState {} // حالت اولیه

class UserLoading extends UserState {} // حالت بارگذاری

class UserAdded extends UserState {} // حالت موفقیت افزودن کاربر

class UserError extends UserState { // حالت خطا
  final String error;
  UserError({required this.error});
}

// for api check registeration
class SendPhoneNumberLoading extends UserState {}

class SendPhoneNumberFailure extends UserState {
  final String error;
  SendPhoneNumberFailure({required this.error});
}

class SendPhoneNumberSuccessful extends UserState {
  final String name;
  final String phone;
  final String role;
  final String location;
  final String username;
  final String password;

  SendPhoneNumberSuccessful({
    required this.name,
    required this.phone,
    required this.role,
    required this.location,
    required this.username,
    required this.password,
  });
}



// api login by usernam password
class LoginLoading extends UserState {}

class LoginSuccessful extends UserState {}

class LoginFailed extends UserState {
  final String error;

  LoginFailed({required this.error});
}
