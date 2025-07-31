part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitialState extends ResetPasswordState {}

final class ResetPasswordLoadingState extends ResetPasswordState {}

final class ResetPasswordSuccessState extends ResetPasswordState {}

final class ResetPasswordFailureState extends ResetPasswordState {
  final String message;
  ResetPasswordFailureState({required this.message});
}
