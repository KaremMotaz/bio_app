import 'dart:convert';
import 'dart:io';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/get_user.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/firebase_auth_service.dart';
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
        imageFile!,
        BackendEndpoint.uploadUsersImages,
      );
      return right(url);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getImage({
    required File? imageFile,
  }) async {
    try {
      String getUrl = await storageService.getImage(
        imageFile!,
        BackendEndpoint.getUsersImages,
      );
      return right(getUrl);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadImageToDatabase({
    required String imageUrl,
  }) async {
    try {
      await firestoreService.editFields(
        collectionName: BackendEndpoint.editFields,
        docId: FirebaseAuthService.userId,
        fields: {
          'imageUrl': imageUrl,
        },
      );
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
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
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
