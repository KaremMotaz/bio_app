part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitialState extends SettingsState {}

final class SettingsLoadingState extends SettingsState {}

final class SettingsSuccessState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;

  SettingsErrorState({required this.message});
}
