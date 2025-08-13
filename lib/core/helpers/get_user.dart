import 'dart:convert';
import 'package:bio_app/core/helpers/constants.dart';
import 'package:bio_app/core/services/cache_helper.dart';
import 'package:bio_app/features/auth/data/models/user_model.dart';
import 'package:bio_app/features/auth/domain/user_entity.dart';

UserEntity getUser(){
  String jsonString = CacheHelper.getString(key: kUserData);
  UserEntity userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}