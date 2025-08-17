part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitialState extends EditProfileState {}

final class EditProfileLoadingState extends EditProfileState {}

final class EditProfileSuccessState extends EditProfileState {}

final class EditProfileErrorState extends EditProfileState {
  final String message;

  EditProfileErrorState({required this.message});
}

final class EditProfileFieldErrorState extends EditProfileState {
  final String errorMessage;

  EditProfileFieldErrorState({required this.errorMessage});
}
