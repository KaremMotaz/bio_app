import 'dart:convert';
import 'constants.dart';
import '../services/cache_helper.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/user_entity.dart';

UserEntity getUser(){
  String jsonString = CacheHelper.getString(key: kUserData);
  UserEntity userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}