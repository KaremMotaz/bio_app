import 'package:bio_app/features/lessons/data/models/lesson_model.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';

class LessonsRemoteDataSource {
  final DatabaseService databaseService;

  LessonsRemoteDataSource({required this.databaseService});
  Future<List<LessonModel>> getFilteredLessons({
    required String unitId,
    required String chapterId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchDoubleSubcollection(
          parentCollection: BackendEndpoint.getUnits,
          parentDocId: unitId,
          firstSubcollection: BackendEndpoint.getChapters,
          firstSubDocId: chapterId,
          secondSubcollection: BackendEndpoint.getLessons,
        );
    return result.map((e) => LessonModel.fromJson(e)).toList();
  }
}
