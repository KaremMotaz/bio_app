import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/firestore_failure.dart';
import 'package:bio_app/features/settings/data/report_model.dart';
import 'package:bio_app/features/settings/data/settings_data_source.dart';
import 'package:bio_app/features/settings/data/review_model.dart';
import 'package:dartz/dartz.dart';

class SettingsRepo {
  final SettingsDataSource dataSource;

  SettingsRepo({required this.dataSource});
  Future<Either<Failure, Unit>> submitReview({
    required ReviewModel reviewModel,
  }) async {
    try {
      await dataSource.submitReview(reviewModel: reviewModel);
      return right(unit);
    } catch (e) {
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
