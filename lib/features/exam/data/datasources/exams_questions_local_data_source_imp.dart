import 'exams_questions_local_data_source.dart';
import '../models/exam_question_model.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';

class ExamsQuestionsLocalDataSourceImp
    implements ExamsQuestionsLocalDataSource {
  final LocalCacheServicee cache;

  ExamsQuestionsLocalDataSourceImp({required this.cache});

  @override
  Future<List<ExamQuestionsModel>?> getExamsQuestions() async {
    try {
      final List<Map<String, dynamic>>? list = await cache.getList(
        key: kExamsQuestions,
        boxName: kExamsQuestionsBox,
      );
      if (list == null) {
        return null;
      }
      return list.map((e) => ExamQuestionsModel.fromJson(e)).toList();
    } catch (e) {
      await clearExamsQuestions();
      return null;
    }
  }

  @override
  Future<void> cacheExamsQuestions(
    List<ExamQuestionsModel> examsQuestions,
  ) async {
    final List<Map<String, dynamic>> list = examsQuestions
        .map((u) => u.toJson())
        .toList();
    await cache.saveList(
      key: kExamsQuestions,
      boxName: kExamsQuestionsBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearExamsQuestions() async {
    await cache.clear(
      key: kExamsQuestions,
      boxName: kExamsQuestionsBox,
    );
  }
}
