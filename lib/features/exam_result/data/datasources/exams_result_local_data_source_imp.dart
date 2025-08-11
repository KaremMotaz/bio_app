import 'package:bio_app/features/exam_result/data/datasources/exams_result_local_data_source.dart';
import 'package:bio_app/features/exam_result/data/models/answers_model.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';

class ExamsResultLocalDataSourceImp
    implements ExamResultLocalDataSource {
  final LocalCacheService cache;

  ExamsResultLocalDataSourceImp({required this.cache});

  @override
  Future<List<AnswersModel>?> getExamsResult() async {
    try {
      final List<Map<String, dynamic>>? list = await cache.getList(
        key: kExamsAnswers,
        boxName: kExamsAnswersBox,
      );
      if (list == null) {
        return null;
      }
      return list.map((e) => AnswersModel.fromJson(e)).toList();
    } catch (e) {
      await clearExamsResult();
      return null;
    }
  }

  @override
  Future<void> cacheExamsResult(
    List<AnswersModel> examsAnswers,
  ) async {
    final List<Map<String, dynamic>> list = examsAnswers
        .map((u) => u.toJson())
        .toList();
    await cache.saveList(
      key: kExamsAnswers,
      boxName: kExamsAnswersBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearExamsResult() async {
    await cache.clear(key: kExamsAnswers, boxName: kExamsAnswersBox);
  }
}
