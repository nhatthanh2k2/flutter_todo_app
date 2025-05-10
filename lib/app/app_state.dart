part of 'app_cubit.dart';

class AppState extends Equatable {
  final AuthenticationStatus status;

  const AppState({this.status = AuthenticationStatus.unknown});

  AppState copyWith({AuthenticationStatus? status}) {
    return AppState(status: status ?? this.status);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}
