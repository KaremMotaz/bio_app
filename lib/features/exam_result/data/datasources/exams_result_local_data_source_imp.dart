import 'exams_result_local_data_source.dart';
import '../models/exams_answers_model.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';

class ExamsResultLocalDataSourceImp
    implements ExamsResultLocalDataSource {
  final LocalCacheService cache;

  ExamsResultLocalDataSourceImp({required this.cache});

  @override
  Future<List<ExamsAnswersModel>?> getExamsResult() async {
    try {
      final List<Map<String, dynamic>>? list = await cache.getList(
        key: kExamsAnswers,
        boxName: kExamsAnswersBox,
      );
      if (list == null) {
        return null;
      }
      return list.map((e) => ExamsAnswersModel.fromJson(e)).toList();
    } catch (e) {
      await clearExamsResult();
      return null;
    }
  }

  @override
  Future<void> cacheExamsResult({
    required List<ExamsAnswersModel> examsResults,
  }) async {
    final List<Map<String, dynamic>> list = examsResults
        .map((u) => u.toJson())
        .toList();

    await cache.saveList(
      key: kExamsAnswers,
      boxName: kExamsAnswersBox,
      list: list,
    );
  }

  @override
  Future<void> clearExamsResult() async {
    await cache.clear(key: kExamsAnswers, boxName: kExamsAnswersBox);
  }
}
