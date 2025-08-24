import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitialState());

  Future<void> deleteAccount() async {
    emit(SettingsLoadingState());
    try {
      
      emit(SettingsSuccessState());
    } catch (e) {
      emit(SettingsErrorState(message: e.toString()));
    }
  }
}
