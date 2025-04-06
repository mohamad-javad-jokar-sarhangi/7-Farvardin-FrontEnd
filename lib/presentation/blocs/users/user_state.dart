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

class SendPhoneNumberSuccessful extends UserState {}
