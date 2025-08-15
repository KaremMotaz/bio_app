import 'dart:io';
import 'package:bio_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ImagesRepo {
  Future<Either<Failure, File>> uploadImageToStorage({
    required File? imageFile,
  });
  Future<Either<Failure, String>> getImage({
    required File? imageFile,
  });
  Future<Either<Failure, String>> uploadImageToDatabase({
    required String imageUrl,
  });

  Future<void> updateCachedUserProfileImage(String newImageUrl);
  Future<Either<Failure, void>> deleteImageFromStorage();
}
