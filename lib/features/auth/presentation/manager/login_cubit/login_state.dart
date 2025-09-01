part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final UserEntity userEntity;

  LoginSuccessState({required this.userEntity});
}

final class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState({required this.message});
}

final class LoginNavigateState extends LoginState {
  final String message;
  final String route;

  LoginNavigateState({required this.message, required this.route});
}
