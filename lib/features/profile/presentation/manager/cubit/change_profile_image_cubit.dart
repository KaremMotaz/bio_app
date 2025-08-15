import 'dart:io';
import 'package:bio_app/features/profile/domain/repos/images_repo.dart';
import 'package:bio_app/features/profile/presentation/helpers/assets_to_file.dart';
import 'package:bio_app/features/profile/presentation/helpers/image_picker_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_profile_image_state.dart';

class ChangeProfileImageCubit extends Cubit<ChangeProfileImageState> {
  final ImagesRepo imagesRepo;

  ChangeProfileImageCubit({required this.imagesRepo})
    : super(ChangeProfileImageInitialState());

  File? _selectedImageFile;

  /// العملية الكاملة من المعرض
  Future<void> changeProfileImageFromGallery() async {
    emit(ChangeProfileImageLoadingState());

    try {
      // 1️⃣ اختيار صورة من المعرض
      final image = await pickImageFromGallery();
      if (image == null) {
        emit(
          const ChangeProfileImageErrorState(
            error: "No image selected",
          ),
        );
        return;
      }
      _selectedImageFile = image;

      // 2️⃣ حذف الصورة القديمة من Storage
      await imagesRepo.deleteImageFromStorage();

      // 2️⃣ رفع الصورالجديدة لـ Storage
      final uploadResult = await imagesRepo.uploadImageToStorage(
        imageFile: _selectedImageFile!,
      );
      final uploadFailure = uploadResult.fold((f) => f, (_) => null);
      if (uploadFailure != null) {
        emit(
          ChangeProfileImageErrorState(
            error: uploadFailure.toString(),
          ),
        );
        return;
      }

      // 3️⃣ جلب رابط الصورة
      final getResult = await imagesRepo.getImage(
        imageFile: _selectedImageFile!,
      );
      String imageUrl = getResult.getOrElse(() => "");

      if (imageUrl.isEmpty) {
        emit(
          const ChangeProfileImageErrorState(
            error: "Failed to get image URL",
          ),
        );
        return;
      }

      emit(ChangeProfileImageLoadedState(imageUrl: imageUrl));

      // 4️⃣ رفع الرابط لقاعدة البيانات
      final uploadToDbResult = await imagesRepo.uploadImageToDatabase(
        imageUrl: imageUrl,
      );
      final dbFailure = uploadToDbResult.fold((f) => f, (_) => null);
      if (dbFailure != null) {
        emit(
          ChangeProfileImageErrorState(error: dbFailure.toString()),
        );
        return;
      }

      // 5️⃣ تحديث الكاش المحلي
      await imagesRepo.updateCachedUserProfileImage(imageUrl);

      emit(ChangeProfileImageSuccessState());
    } catch (e) {
      emit(ChangeProfileImageErrorState(error: e.toString()));
    }
  }

  /// العملية الكاملة من Avatar
  Future<void> changeProfileImageFromAvatar({
    required String avatarPath,
  }) async {
    emit(ChangeProfileImageLoadingState());
    try {
      // 1️⃣ تحويل الـ Asset لملف
      final avatarFile = await assetToFile(avatarPath);
      _selectedImageFile = avatarFile;

      // 2️⃣ رفع الصورة
      final uploadResult = await imagesRepo.uploadImageToStorage(
        imageFile: avatarFile,
      );
      final uploadFailure = uploadResult.fold((f) => f, (_) => null);
      if (uploadFailure != null) {
        emit(
          ChangeProfileImageErrorState(
            error: uploadFailure.toString(),
          ),
        );
        return;
      }

      // 3️⃣ جلب الرابط
      final getResult = await imagesRepo.getImage(
        imageFile: avatarFile,
      );
      String imageUrl = getResult.getOrElse(() => "");

      if (imageUrl.isEmpty) {
        emit(
          const ChangeProfileImageErrorState(
            error: "Failed to get image URL",
          ),
        );
        return;
      }

      emit(ChangeProfileImageLoadedState(imageUrl: imageUrl));

      // 4️⃣ رفع الرابط لقاعدة البيانات
      final uploadToDbResult = await imagesRepo.uploadImageToDatabase(
        imageUrl: imageUrl,
      );
      final dbFailure = uploadToDbResult.fold((f) => f, (_) => null);
      if (dbFailure != null) {
        emit(
          ChangeProfileImageErrorState(error: dbFailure.toString()),
        );
        return;
      }

      // 5️⃣ تحديث الكاش المحلي
      await imagesRepo.updateCachedUserProfileImage(imageUrl);

      emit(ChangeProfileImageSuccessState());
    } catch (e) {
      emit(ChangeProfileImageErrorState(error: e.toString()));
    }
  }
}
