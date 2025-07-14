import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_verification_state.dart';

class AuthVerificationCubit extends Cubit<AuthVerificationState> {
  AuthVerificationCubit() : super(AuthVerificationInitial());
}
