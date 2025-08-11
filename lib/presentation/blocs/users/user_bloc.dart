import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    // API
    on<AddUser>(_onAddUser);
    on<SendPhoneNumberEvent>(_onCheckUser);
    on<LoginUserEvent>(_onLoginUser);
  }

  // initial register user by api 
  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.addUser(event.name, event.phone, event.role , event.location);
      emit(UserAdded());
    } catch (error) {
      emit(UserError(error: error.toString()));
    }
  }

  // for api check registeration
  Future<void> _onCheckUser(SendPhoneNumberEvent event, Emitter<UserState> emit) async {
    emit(SendPhoneNumberLoading());
    try {
      // دریافت اطلاعات کاربر از API
      final userData = await userRepository.sendPhoneAndGetCredentials(event.phoneNumber);
      
      // ذخیره اطلاعات دریافتی در SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      
      // ذخیره تمام اطلاعات دریافتی
      await prefs.setString('user_name', userData['name'] ?? '');
      await prefs.setString('phone', userData['phone'] ?? '');
      await prefs.setString('role', userData['role'] ?? '');
      await prefs.setString('location', userData['location'] ?? '');
      await prefs.setString('username', userData['username'] ?? '');
      await prefs.setString('password', userData['password'] ?? '');
      
      emit(SendPhoneNumberSuccessful(
        name: userData['name'] ?? '',
        phone: userData['phone'] ?? '',
        role: userData['role'] ?? '',
        location: userData['location'] ?? '',
        username: userData['username'] ?? '',
        password: userData['password'] ?? '',
      ));
    } catch (error) {
      emit(SendPhoneNumberFailure(error: error.toString()));
    }
  }




// api login by usernam password
  Future<void> _onLoginUser(LoginUserEvent event, Emitter<UserState> emit) async {
  emit(LoginLoading());
  try {
    // فراخوانی متد API در Repository
    final isLoginSuccessful = await userRepository.loginUser(event.username, event.password);
    if (isLoginSuccessful) {
      emit(LoginSuccessful());
    } else {
      emit(LoginFailed(error: 'نام کاربری یا رمز عبور اشتباه است.'));
    }
  } catch (error) {
    emit(LoginFailed(error: error.toString()));
  }
}

}
