import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({required this.authRepo})
    : super(ResetPasswordInitialState());

  final AuthRepo authRepo;

  Future<void> sendLinkToResetPassword({
    required TextEditingController emailController,
  }) async {
    emit(ResetPasswordLoadingState());
    final result = await authRepo.sendLinkToResetPassword(
      email: emailController.text,
    );
    result.fold(
      (failure) {
        emit(ResetPasswordFailureState(message: failure.errMessage));
      },
      (unit) {
        emit(ResetPasswordSuccessState());
      },
    );
  }
}
