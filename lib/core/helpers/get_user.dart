import 'dart:convert';

import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/user_entity.dart';
import '../services/cache_helper.dart';
import 'constants.dart';

UserEntity getUser(){
  String jsonString = CacheHelper.getString(key: kUserData);
  UserEntity userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}

Future<void> saveUser(UserEntity user) async {
  final jsonString = jsonEncode(UserModel.fromEntity(user).toJson());
  await CacheHelper.set(key: kUserData, value: jsonString);
}