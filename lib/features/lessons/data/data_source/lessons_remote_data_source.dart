import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';
import '../models/lesson_model.dart';

class LessonsRemoteDataSource {
  final DatabaseService databaseService;

  LessonsRemoteDataSource({required this.databaseService});
  Future<List<LessonModel>> getFilteredLessons({
    required String unitId,
    required String chapterId,
  }) async {
    final List<Map<String, dynamic>>
    result = await databaseService.getData(
      path:
          '${BackendEndpoint.getUnits}/$unitId/${BackendEndpoint.getChapters}/$chapterId/${BackendEndpoint.getLessons}',
    );
    return result.map((e) => LessonModel.fromJson(e)).toList();
  }
}
