import 'dart:io';
import 'package:bio_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ImagesRepo {
  Future<Either<Failure, File>> uploadImage({required File? imageUrl});
  Future<Either<Failure, String>> getImage({required File? imageUrl});
}
