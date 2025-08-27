import 'dart:convert';
import 'package:bio_app/core/helpers/get_user.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/cache_failure.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/data_service.dart';

class UserDataRepoImp {
  final DatabaseService databaseService;

  UserDataRepoImp({required this.databaseService});

  Future<Either<Failure, void>> updateData({
    required String value,
    required String fieldName,
  }) async {
    try {
      await databaseService.updateData(
        path: '${BackendEndpoint.editFields}/${getUser().uid}',
        data: {fieldName: value},
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.unknown(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateCachedUser({
    required String fieldName,
    required String value,
  }) async {
    try {
      final String userJson = CacheHelper.getString(key: kUserData);

      if (userJson.isEmpty) {
        return Left(CacheFailure.empty());
      }

      final Map<String, dynamic> userMap = jsonDecode(userJson);
      userMap[fieldName] = value;

      CacheHelper.set(key: kUserData, value: jsonEncode(userMap));

      return const Right(null);
    } on FormatException {
      return Left(CacheFailure.invalidFormat());
    } catch (e) {
      return Left(CacheFailure.unknown(e.toString()));
    }
  }
}
