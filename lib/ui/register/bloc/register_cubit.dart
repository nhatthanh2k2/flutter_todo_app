import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/authentication_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterCubit({required this.authenticationRepository})
    : super(const RegisterState());

  Future<void> register(String email, String password) async {
    try {
      await authenticationRepository.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {}
  }
}
