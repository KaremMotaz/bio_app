import 'dart:io';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/profile/domain/repos/images_repo.dart';
import 'package:bio_app/features/profile/presentation/helpers/assets_to_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_profile_image_state.dart';

class ChangeProfileImageCubit extends Cubit<ChangeProfileImageState> {
  final ImagesRepo imagesRepo;
  ChangeProfileImageCubit({required this.imagesRepo})
    : super(ChangeProfileImageInitialState());

  File? selectedImage;
  String? selectedAvatarPath = AssetsData.dummyUserImage;
  File? selectedAvatarPathFile;

  void selectImage({
    required File? image,
    required String? avatarPath,
  }) async {
    selectedImage = image;
    selectedAvatarPath = avatarPath ?? selectedAvatarPath;
    selectedAvatarPathFile = await assetToFile(selectedAvatarPath!);
    emit(
      ChangeProfileImageSelectedState(
        selectedImage: selectedImage,
        selectedAvatarPath: selectedAvatarPath!,
      ),
    );
  }

  Future<void> uploadImage() async {
    await imagesRepo.uploadImage(
      imageUrl: selectedImage ?? selectedAvatarPathFile,
    );
  }

  Future<String> getImage() async {
    final result = await imagesRepo.getImage(
      imageUrl: selectedImage ?? selectedAvatarPathFile,
    );
    return result.fold(
      (failure) => throw failure,
      (imageUrl) => imageUrl,
    );
  }

  Future<void> changeProfileImage(String imagePath) async {
    emit(ChangeProfileImageLoadingState());
    try {
      emit(ChangeProfileImageSuccessState());
    } catch (e) {
      emit(ChangeProfileImageErrorState(error: e.toString()));
    }
  }
}
