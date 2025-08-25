import '../../../../../core/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/firebase_auth_service.dart';
import '../../../domain/auth_repo.dart';
import '../../../domain/user_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitialState());

  final AuthRepo authRepo;

  Future<bool> showUserIsOldOrNot() async {
    if (FirebaseAuthService(
      databaseService: FirestoreService(),
    ).isLoggedIn()) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      UserEntity userData = await authRepo.getUserData(uid: uid);
      bool oldUser = userData.oldUser;
      return oldUser;
    }
    return false;
  }

  Future<void> signinWithEmailAndPassword({
    required TextEditingController passwordController,
    required TextEditingController emailController,
  }) async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithEmailAndPassword(
      password: passwordController.text,
      email: emailController.text,
    );
    result.fold(
      (failure) {
        emit(LoginFailureState(message: failure.message));
      },
      (userEntity) {
        emit(LoginSuccessState(userEntity: userEntity));
      },
    );
  }

  Future<void> signinWithGoogle() async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithGoogle();
    result.fold(
      (failure) {
        emit(LoginFailureState(message: failure.message));
      },
      (userEntity) {
        emit(LoginSuccessState(userEntity: userEntity));
      },
    );
  }

  Future<void> signinWithFacebook() async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithFacebook();
    result.fold(
      (failure) {
        emit(LoginFailureState(message: failure.message));
      },
      (userEntity) {
        emit(LoginSuccessState(userEntity: userEntity));
      },
    );
  }

  getUserData() async {}
}
