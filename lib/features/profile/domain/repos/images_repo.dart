import 'dart:io';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ImagesRepo {
  Future<Either<Failure, File>> uploadImageToStorage({
    required File? imageFile,
  });
  Future<Either<Failure, String>> getImage({
    required File? imageFile,
  });
  Future<Either<Failure, Unit>> uploadImageToDatabase({
    required String imageUrl,
  });

  Future<void> updateCachedUserProfileImage(String newImageUrl);
  Future<Either<Failure, void>> deleteImageFromStorage();
}
