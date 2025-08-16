import 'package:bio_app/features/profile/data/repos/user_data_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  UserDataRepoImp userDataRepoImp;

  EditProfileCubit({required this.userDataRepoImp})
    : super(EditProfileInitialState());

  void updateFirstName({required String newFirstName}) async {
    emit(EditProfileLoadingState());
    await userDataRepoImp.updateData(
      value: newFirstName,
      fieldName: 'firstName',
    );
    await userDataRepoImp.updateCachedUser(
      fieldName: 'firstName',
      value: newFirstName,
    );
    emit(EditProfileSuccessState());
  }

  void updateLastName({required String newLastName}) async {
    emit(EditProfileLoadingState());
    await userDataRepoImp.updateData(
      value: newLastName,
      fieldName: 'lastName',
    );
    await userDataRepoImp.updateCachedUser(
      fieldName: 'lastName',
      value: newLastName,
    );
    emit(EditProfileSuccessState());
  }

  void updatePhoneNumber({required String newPhoneNumber}) async {
    emit(EditProfileLoadingState());
    await userDataRepoImp.updateData(
      value: newPhoneNumber,
      fieldName: 'phoneNumber',
    );
    await userDataRepoImp.updateCachedUser(
      fieldName: 'phoneNumber',
      value: newPhoneNumber,
    );
    emit(EditProfileSuccessState());
  }
}
