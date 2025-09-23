import '../helpers/constants.dart';
import '../../features/chapters/data/models/chapter_model_adapter.dart';
import '../../features/exam/data/models/exam_model_adapter.dart';
import '../../features/exam/data/models/exam_question_model_adapter.dart';
import '../../features/exam_result/data/models/exams_answers_model_adapter.dart';
import '../../features/lessons/data/models/lesson_model_adapter.dart';
import '../../features/lessons/data/models/quiz_model_adapter.dart';
import '../../features/quiz_questions/data/models/quiz_question_model_adapter.dart';
import '../../features/units/data/models/unit_model_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Units
    Hive.registerAdapter(UnitModelAdapter());
    await Hive.openBox(kUnitsBox);

    // Chapters
    Hive.registerAdapter(ChapterModelAdapter());
    await Hive.openBox(kChaptersBox);

    // Lessons
    Hive.registerAdapter(LessonModelAdapter());
    await Hive.openBox(kLessonsBox);

    // Quizzes
    Hive.registerAdapter(QuizModelAdapter());
    await Hive.openBox(kQuizzesBox);

    // Quiz Questions
    Hive.registerAdapter(QuizQuestionModelAdapter());
    await Hive.openBox(kQuizQuestionsBox);

    // Exams
    Hive.registerAdapter(ExamModelAdapter());
    await Hive.openBox(kExamsBox);

    // Exam Questions
    Hive.registerAdapter(ExamQuestionsModelAdapter());
    await Hive.openBox(kExamsQuestionsBox);

    // Exam Answers (مع الشرط بتاع التسجيل مرة واحدة)
    if (!Hive.isAdapterRegistered(ExamsAnswersModelAdapter().typeId)) {
      Hive.registerAdapter(ExamsAnswersModelAdapter());
    }
    
    await Hive.openBox(kExamsAnswersBox);

    // Cache
    await Hive.openBox(kAppCacheBox);
  }
}
