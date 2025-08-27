import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';
import '../models/exam_model.dart';
import 'exams_local_data_source.dart';

class ExamsLocalDataSourceImp implements ExamsLocalDataSource {
  final LocalCacheService<ExamModel> cache;

  ExamsLocalDataSourceImp({required this.cache});

  @override
  Future<List<ExamModel>?> getExams() async {
    try {
      final List<ExamModel>? list = await cache.getList(
        key: kExams,
        boxName: kExamsBox,
      );
      if (list == null) {
        return null;
      }
      return list;
    } catch (e) {
      await clearExams();
      return null;
    }
  }

  @override
  Future<void> cacheExams(List<ExamModel> exams) async {
    await cache.saveList(
      key: kExams,
      boxName: kExamsBox,
      list: exams,
    );
  }

  @override
  Future<void> clearExams() async {
    await cache.clear(key: kExams, boxName: kExamsBox);
  }
}
