import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';
import '../models/exams_answers_model.dart';
import 'exams_result_local_data_source.dart';

class ExamsResultLocalDataSourceImp
    implements ExamsResultLocalDataSource {
  final LocalCacheService<ExamsAnswersModel> cache;

  ExamsResultLocalDataSourceImp({required this.cache});

  @override
  Future<List<ExamsAnswersModel>?> getExamsResult() async {
    try {
      final List<ExamsAnswersModel>? list = await cache.getList(
        key: kExamsAnswers,
        boxName: kExamsAnswersBox,
      );
      if (list == null) {
        return null;
      }
      return list;
    } catch (e) {
      await clearExamsResult();
      return null;
    }
  }

  @override
  Future<void> cacheExamsResult({
    required List<ExamsAnswersModel> examsResults,
  }) async {
    await cache.saveList(
      key: kExamsAnswers,
      boxName: kExamsAnswersBox,
      list: examsResults,
    );
  }

  @override
  Future<void> clearExamsResult() async {
    await cache.clear(key: kExamsAnswers, boxName: kExamsAnswersBox);
  }
}
