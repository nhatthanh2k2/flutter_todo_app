import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/auth/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository})
    : super(const LoginState(""));

  Future<void> login(String email, String password) async {
    try {
      await authenticationRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {}
  }
}
