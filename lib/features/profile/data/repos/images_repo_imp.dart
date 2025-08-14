import 'dart:io';
import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/services/storage_service.dart';

import '../../domain/repos/images_repo.dart';

import 'package:dartz/dartz.dart';

class ImagesRepoImp implements ImagesRepo {
  final StorageService storageService;
  ImagesRepoImp({required this.storageService});

  @override
  Future<Either<Failure, File>> uploadImage({required File? imageUrl}) async {
    try {
      File url = await storageService.uploadFile(
          imageUrl!, BackendEndpoint.uploadUsersImages);
      return right(url);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getImage({required File? imageUrl}) async {
    try {
      String getUrl = await storageService.getImage(
          imageUrl!, BackendEndpoint.getUsersImages);
      return right(getUrl);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
