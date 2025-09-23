import '../../../core/helpers/backend_endpoint.dart';
import '../../../core/helpers/get_user.dart';
import '../../../core/services/data_service.dart';
import 'models/report_model.dart';
import 'models/app_rating_model.dart';

class SettingsDataSource {
  final DatabaseService databaseService;

  SettingsDataSource({required this.databaseService});
  Future<void> submitAppRating({
    required AppRatingModel appRatingModel,
  }) async {
    await databaseService.addData(
      path: BackendEndpoint.addAppRating,
      data: appRatingModel.toJson(),
      documentId: appRatingModel.userId,
    );
  }

  Future<Map<String, dynamic>> getAppRating() async {
    return await databaseService.getData(
      path: '${BackendEndpoint.getAppRating}/${getUser().uid}',
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
