import 'dart:convert';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helpers/get_user.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/repos/images_repo.dart';
import 'package:dartz/dartz.dart';

class ImagesRepoImp implements ImagesRepo {
  final StorageService storageService;
  final FirestoreService firestoreService;
  ImagesRepoImp({
    required this.storageService,
    required this.firestoreService,
  });

  @override
  Future<Either<Failure, File>> uploadImageToStorage({
    required File? imageFile,
  }) async {
    try {
      File url = await storageService.uploadFile(
        uid: getUser().uid,
        file: imageFile!,
        path: BackendEndpoint.uploadUsersImages,
      );
      return right(url);
    } on StorageException catch (e) {
      return left(
        ServerFailure(message: "خطأ في التخزين: ${e.message}"),
      );
    } on PostgrestException catch (e) {
      return left(
        ServerFailure(message: "خطأ في قاعدة البيانات: ${e.message}"),
      );
    } catch (e) {
      return left(
        ServerFailure(message: "خطأ غير متوقع: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getImage({
    required File? imageFile,
  }) async {
    try {
      String getUrl = await storageService.getImage(
        uid: getUser().uid,
        file: imageFile!,
        path: BackendEndpoint.getUsersImages,
      );
      return right(getUrl);
    } on StorageException catch (e) {
      return left(
        ServerFailure(message: "خطأ في التخزين: ${e.message}"),
      );
    } on PostgrestException catch (e) {
      return left(
        ServerFailure(message: "خطأ في قاعدة البيانات: ${e.message}"),
      );
    } catch (e) {
      return left(
        ServerFailure(message: "خطأ غير متوقع: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadImageToDatabase({
    required String imageUrl,
  }) async {
    try {
      await firestoreService.updateData(
        path: '${BackendEndpoint.editFields}/${getUser().uid}',
        data: {'imageUrl': imageUrl},
      );
      return right(unit);
    } on StorageException catch (e) {
      return left(
        ServerFailure(message: "خطأ في التخزين: ${e.message}"),
      );
    } on PostgrestException catch (e) {
      return left(
        ServerFailure(message: "خطأ في قاعدة البيانات: ${e.message}"),
      );
    } catch (e) {
      return left(
        ServerFailure(message: "خطأ غير متوقع: ${e.toString()}"),
      );
    }
  }

  @override
  Future<void> updateCachedUserProfileImage(
    String newImageUrl,
  ) async {
    // 1️⃣ قراءة بيانات المستخدم القديمة من الكاش
    final String userJson = CacheHelper.getString(key: kUserData);
    if (userJson.isEmpty) return; // مفيش بيانات

    // 2️⃣ فك JSON ل Map
    final Map<String, dynamic> userMap = jsonDecode(userJson);

    // 3️⃣ تعديل قيمة imageUrl
    userMap['imageUrl'] = newImageUrl;

    // 4️⃣ إعادة الحفظ في الكاش
    await CacheHelper.set(key: kUserData, value: jsonEncode(userMap));
  }

  @override
  Future<Either<Failure, void>> deleteImageFromStorage() async {
    try {
      final currentUser = getUser();
      final uri = Uri.parse(currentUser.imageUrl!);
      if (uri.pathSegments.length < 6) return const Right(null);

      final bucketName = uri.pathSegments[4];
      final filePath = uri.pathSegments.sublist(5).join('/');
      await storageService.deleteImageFromStorage(
        bucket: bucketName,
        filePath: filePath,
      );

      return const Right(null);
    } on StorageException catch (e) {
      return left(
        ServerFailure(message: "خطأ في التخزين: ${e.message}"),
      );
    } on PostgrestException catch (e) {
      return left(
        ServerFailure(message: "خطأ في قاعدة البيانات: ${e.message}"),
      );
    } catch (e) {
      return left(
        ServerFailure(message: "خطأ غير متوقع: ${e.toString()}"),
      );
    }
  }
}
