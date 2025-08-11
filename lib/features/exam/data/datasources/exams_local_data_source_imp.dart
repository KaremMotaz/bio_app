import 'package:bio_app/features/exam/data/datasources/exams_local_data_source.dart';
import 'package:bio_app/features/exam/data/models/exam_model.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';

class ExamsLocalDataSourceImp implements ExamsLocalDataSource {
  final LocalCacheService cache;

  ExamsLocalDataSourceImp({required this.cache});

  @override
  Future<List<ExamModel>?> getExams() async {
    try {
      final List<Map<String, dynamic>>? list = await cache.getList(
        key: kExams,
        boxName: kExamsBox,
      );
      if (list == null) {
        return null;
      }
      return list.map((e) => ExamModel.fromJson(e)).toList();
    } catch (e) {
      await clearExams();
      return null;
    }
  }

  @override
  Future<void> cacheExams(List<ExamModel> exams) async {
    final List<Map<String, dynamic>> list = exams
        .map((u) => u.toJson())
        .toList();
    await cache.saveList(
      key: kExams,
      boxName: kExamsBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearExams() async {
    await cache.clear(key: kExams, boxName: kExamsBox);
  }
}
