import 'dart:convert';

import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/helpers/constants.dart';
import 'package:bio_app/core/services/cache_helper.dart';
import 'package:bio_app/core/services/data_service.dart';
import 'package:bio_app/core/services/firebase_auth_service.dart';

class UserDataRepoImp {
  DatabaseService databaseService;

  UserDataRepoImp({required this.databaseService});
  Future<void> updateData({
    required String value,
    required String fieldName,
  }) async {
    await databaseService.editField(
      collectionName: BackendEndpoint.editField,
      docId: FirebaseAuthService.userId,
      fieldName: fieldName,
      value: value,
    );
  }

  Future<void> updateCachedUser({
    required String fieldName,
    required String value,
  }) async {
    final String userJson = CacheHelper.getString(key: kUserData);
    if (userJson.isEmpty) return;
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    userMap[fieldName] = value;
    await CacheHelper.set(key: kUserData, value: jsonEncode(userMap));
  }
}
