import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/data/repositories/user_repository.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<AddUser>(_onAddUser);
  }

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.addUser(event.name, event.phone, event.role);
      emit(UserAdded());
    } catch (error) {
      emit(UserError(error: error.toString()));
    }
  }
}
