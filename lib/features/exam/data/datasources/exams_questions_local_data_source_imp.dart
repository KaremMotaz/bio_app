import 'package:bio_app/core/services/local_cache_service.dart';
import 'exams_questions_local_data_source.dart';
import '../models/exam_question_model.dart';
import '../../../../core/helpers/constants.dart';

class ExamsQuestionsLocalDataSourceImp
    implements ExamsQuestionsLocalDataSource {
  final LocalCacheService<ExamQuestionsModel> cache;

  ExamsQuestionsLocalDataSourceImp({required this.cache});

  @override
  Future<List<ExamQuestionsModel>?> getExamsQuestions() async {
    try {
      final List<ExamQuestionsModel>? list = await cache.getList(
        key: kExamsQuestions,
        boxName: kExamsQuestionsBox,
      );
      if (list == null) {
        return null;
      }
      return list;
    } catch (e) {
      await clearExamsQuestions();
      return null;
    }
  }

  @override
  Future<void> cacheExamsQuestions(
    List<ExamQuestionsModel> examsQuestions,
  ) async {
    await cache.saveList(
      key: kExamsQuestions,
      boxName: kExamsQuestionsBox,
      list: examsQuestions,
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
