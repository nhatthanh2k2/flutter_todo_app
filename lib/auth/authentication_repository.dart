import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/auth/firebase_auth_service.dart';
import 'package:todo_app/utils/enums/authentication_status.dart';

import '../entities/user_entity.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  Stream<UserEntity> get user;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuthService firebaseAuthService;

  final _statusController = StreamController<AuthenticationStatus>();
  final _userController = StreamController<UserEntity>();

  AuthenticationRepositoryImpl({required this.firebaseAuthService}) {
    firebaseAuthService.user.listen((firebaseUser) {
      final isLoggedIn = firebaseUser != null;
      final user = isLoggedIn ? firebaseUser.toUserEntity : UserEntity.empty;
      _userController.sink.add(user);
      if (isLoggedIn) {
        _statusController.sink.add(AuthenticationStatus.authenticated);
      } else {
        _statusController.sink.add(AuthenticationStatus.unauthenticated);
      }
    });
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuthService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuthService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Register error: $e');
      rethrow;
    }
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;

    yield* _statusController.stream;
  }

  @override
  Stream<UserEntity> get user async* {
    yield* _userController.stream;
  }
}

extension UserFirebaseAuthExtension on User {
  UserEntity get toUserEntity {
    return UserEntity(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
    );
  }
}
