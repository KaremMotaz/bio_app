import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth_repo.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.authRepo) : super(LogOutInitialState());
  final AuthRepo authRepo;

  Future<void> logOut() async {
    emit(LogOutLoadingState());
    final result = await authRepo.logOut();
    result.fold(
      (failure) {
        emit(LogOutFailureState(message: failure.errMessage));
      },
      (unit) {
        emit(LogOutSuccessState());
      },
    );
  }
}
