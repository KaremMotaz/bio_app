import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/services/data_service.dart';
import 'package:bio_app/features/settings/data/report_model.dart';
import 'package:bio_app/features/settings/data/review_model.dart';

class SettingsDataSource {
  final DatabaseService databaseService;

  SettingsDataSource({required this.databaseService});
  Future<void> submitReview({
    required ReviewModel reviewModel,
  }) async {
    await databaseService.addData(
      path: BackendEndpoint.addReview,
      data: reviewModel.toJson(),
    );
  }
  Future<void> submitReport({
    required ReportModel reportModel,
  }) async {
    await databaseService.addData(
      path: BackendEndpoint.addReport,
      data: reportModel.toJson(),
    );
  }
}
