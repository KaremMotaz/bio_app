
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth_repo.dart';
import '../../../domain/user_entity.dart';

part 'fill_profile_state.dart';

class FillProfileCubit extends Cubit<FillProfileState> {
  FillProfileCubit(this.authRepo)
    : super(FillProfileInitialState());

  final AuthRepo authRepo;
  final User user = FirebaseAuth.instance.currentUser!;

  Future<void> fillProfile({
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController phoneNumberController,
  }) async {
    emit(FillProfileLoadingState());

    final result = await authRepo.addUserData(
      userEntity: UserEntity(
        email: user.email!,
        uid: user.uid,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneNumberController.text,
        oldUser: true,
        imageUrl: "",
      ),
    );
    result.fold(
      (failure) {
        emit(FillProfileFailureState(message: failure.errMessage));
      },
      (userEntity) {
        emit(FillProfileSuccessState(userEntity: userEntity));
      },
    );
  }
}
