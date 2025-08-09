import 'package:bio_app/features/chapters/data/models/chapter_model.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';

class ChaptersRemoteDataSource {
  final DatabaseService databaseService;

  ChaptersRemoteDataSource({required this.databaseService});
  Future<List<ChapterModel>> getFilteredChapters({
    required String unitId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getUnits,
          parentDocId: unitId,
          subCollection: BackendEndpoint.getChapters,
        );
    return result.map((e) => ChapterModel.fromJson(e)).toList();
  }
}
