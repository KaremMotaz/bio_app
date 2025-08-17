import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth_repo.dart';
import '../../../domain/user_entity.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitialState());

  final AuthRepo authRepo;

  Future<void> signupWithEmailAndPassword({
    required TextEditingController passwordController,
    required TextEditingController emailController,
  }) async {
    emit(SignupLoadingState());
    final result = await authRepo.signupWithEmailAndPassword(
      password: passwordController.text,
      email: emailController.text,
    );
    result.fold(
      (failure) {
        emit(SignupFailureState(message: failure.message));
      },
      (userEntity) async {
        await authRepo.sendEmailVerification();
        emit(SignupSuccessState(userEntity: userEntity));
      },
    );
  }
}
