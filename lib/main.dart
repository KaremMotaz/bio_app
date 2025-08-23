import 'package:bio_app/features/chapters/data/models/chapter_model_adapter.dart';
import 'package:bio_app/features/exam/data/models/exam_model_adapter.dart';
import 'package:bio_app/features/exam/data/models/exam_question_model_adapter.dart';
import 'package:bio_app/features/exam_result/data/models/exams_answers_model_adapter.dart';
import 'package:bio_app/features/lessons/data/models/lesson_model_adapter.dart';
import 'package:bio_app/features/lessons/data/models/quiz_model_adapter.dart';
import 'package:bio_app/features/quiz_questions/data/models/quiz_question_model_adapter.dart';
import 'package:bio_app/features/units/data/models/unit_model_adapter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/helpers/constants.dart';
import 'core/routing/app_router.dart';
import 'core/services/cache_helper.dart';
import 'core/services/get_it_service.dart';
import 'core/services/supabase_storage_service.dart';
import 'core/theming/text_styles.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UnitModelAdapter());
  await Hive.openBox(kUnitsBox);
  Hive.registerAdapter(ChapterModelAdapter());
  await Hive.openBox(kChaptersBox);
  Hive.registerAdapter(LessonModelAdapter());
  await Hive.openBox(kLessonsBox);
  Hive.registerAdapter(QuizModelAdapter());
  await Hive.openBox(kQuizzesBox);
  Hive.registerAdapter(QuizQuestionModelAdapter());
  await Hive.openBox(kQuizQuestionsBox);
  Hive.registerAdapter(ExamModelAdapter());
  await Hive.openBox(kExamsBox);
  Hive.registerAdapter(ExamQuestionsModelAdapter());
  await Hive.openBox(kExamsQuestionsBox);
  Hive.registerAdapter(ExamsAnswersModelAdapter());
  await Hive.openBox(kExamsAnswersBox);
  await Hive.openBox(kAppCacheBox);
  await SupabaseStorageService.initSupabase();
  await SupabaseStorageService.createBuckets(kBucketName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  setupGetIt();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale("ar"),
      supportedLocales: const [Locale('ar')],
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyles.bold18.copyWith(
            color: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.createRouter(),
    );
  }
}
