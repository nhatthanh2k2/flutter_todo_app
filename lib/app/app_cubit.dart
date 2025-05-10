import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/auth/authentication_repository.dart';
import 'package:todo_app/utils/enums/authentication_status.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthenticationRepository authenticationRepository;

  AppCubit({required this.authenticationRepository}) : super(const AppState()) {
    authenticationRepository.status.listen((status) {
      emit(state.copyWith(status: status));
    });
  }
}
