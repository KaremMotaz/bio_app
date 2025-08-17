import 'package:flutter/material.dart';

import '../../../data/repos/user_data_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserDataRepoImp userDataRepoImp;

  EditProfileCubit({required this.userDataRepoImp})
    : super(EditProfileInitialState());

  Future<void> updateFirstName({required String newFirstName}) async {
    emit(EditProfileLoadingState());
    final result = await userDataRepoImp.updateData(
      value: newFirstName,
      fieldName: 'firstName',
    );

    result.fold(
      (failure) =>
          emit(EditProfileErrorState(message: failure.message)),
      (_) async {
        await userDataRepoImp.updateCachedUser(
          fieldName: 'firstName',
          value: newFirstName,
        );
        emit(EditProfileSuccessState());
      },
    );
  }

  Future<void> updateLastName({required String newLastName}) async {
    emit(EditProfileLoadingState());
    final result = await userDataRepoImp.updateData(
      value: newLastName,
      fieldName: 'lastName',
    );

    result.fold(
      (failure) =>
          emit(EditProfileErrorState(message: failure.message)),
      (_) async {
        await userDataRepoImp.updateCachedUser(
          fieldName: 'lastName',
          value: newLastName,
        );
        emit(EditProfileSuccessState());
      },
    );
  }

  Future<void> updatePhoneNumber({
    required String newPhoneNumber,
  }) async {
    emit(EditProfileLoadingState());
    final result = await userDataRepoImp.updateData(
      value: newPhoneNumber,
      fieldName: 'phoneNumber',
    );

    result.fold(
      (failure) =>
          emit(EditProfileErrorState(message: failure.message)),
      (_) async {
        await userDataRepoImp.updateCachedUser(
          fieldName: 'phoneNumber',
          value: newPhoneNumber,
        );
        emit(EditProfileSuccessState());
      },
    );
  }
}
