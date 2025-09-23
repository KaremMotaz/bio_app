import 'dart:developer';

import '../../../core/errors/failure.dart';
import '../../../core/errors/firestore_failure.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/get_user.dart';
import '../../../core/services/cache_helper.dart';
import 'models/report_model.dart';
import 'settings_data_source.dart';
import 'models/app_rating_model.dart';
import 'package:dartz/dartz.dart';

class SettingsRepo {
  final SettingsDataSource dataSource;

  SettingsRepo({required this.dataSource});
  Future<Either<Failure, Unit>> submitAppRating({
    required AppRatingModel appRatingModel,
  }) async {
    try {
      await dataSource.submitAppRating(
        appRatingModel: appRatingModel,
      );
      await CacheHelper.set(
        key: kUserRating,
        value: appRatingModel.rating ?? 0.0,
      );
      return right(unit);
    } catch (e) {
      log("From submit app rating $e");
      return left(FirestoreFailure.fromCode(e.toString()));
    }
  }

  Future<Either<Failure, AppRatingModel>> getAppRating() async {
    try {
      // 1. Load cached rating
      final localRating = CacheHelper.getDouble(key: kUserRating);

      if (localRating != null) {
        return Right(
          AppRatingModel(userId: getUser().uid, rating: localRating),
        );
      }

      // 2. Load from database
      final Map<String, dynamic> result = await dataSource
          .getAppRating();
      final AppRatingModel appRatingModel = AppRatingModel.fromJson(
        result,
      );

      // 3. Save to cache
      await CacheHelper.set(
        key: kUserRating,
        value: appRatingModel.rating,
      );

      return right(appRatingModel);
    } catch (e) {
      log("From get app Rating $e");
      return left(FirestoreFailure.fromCode(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> submitReport({
    required ReportModel reportModel,
  }) async {
    try {
      await dataSource.submitReport(reportModel: reportModel);
      return right(unit);
    } catch (e) {
      return left(FirestoreFailure.fromCode(e.toString()));
    }
  }
}
