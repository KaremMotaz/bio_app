import 'package:bio_app/features/exam/data/datasources/exam_questions_remote_data_source.dart';
import 'package:bio_app/features/exam/data/datasources/exams_local_data_source_imp.dart';
import 'package:bio_app/features/exam/data/repos/exam_questions_repo_impl.dart';
import 'package:bio_app/features/exam_result/data/datasources/exam_result_remote_data_source.dart';
import 'package:bio_app/features/quiz_questions/data/data_source/quiz_questions_local_data_source_imp.dart';
import 'package:bio_app/features/quiz_questions/data/data_source/quiz_questions_remote_data_source.dart';

import '../../features/chapters/data/data_source/chapters_local_data_source.dart';
import '../../features/lessons/data/data_source/lessons_local_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_local_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_local_data_source_imp.dart';
import '../../features/lessons/data/data_source/quizzes_remote_data_source.dart';
import '../../features/lessons/data/repos/quiz_repo_imp.dart';
import '../../features/units/data/data_source/units_local_data_source.dart';

import 'local_cache_service.dart';
import '../../features/chapters/data/data_source/chapters_local_data_source_imp.dart';
import '../../features/chapters/data/data_source/chapters_remote_data_source.dart';
import '../../features/chapters/data/repos/chapter_repo_imp.dart';
import '../../features/lessons/data/data_source/lessons_local_data_source_imp.dart';
import '../../features/lessons/data/data_source/lessons_remote_data_source.dart';
import '../../features/lessons/data/repos/lesson_repo_imp.dart';
import '../../features/quiz_questions/domain/logic/quiz_helpers.dart';
import '../../features/units/data/data_source/units_local_data_source_imp.dart';
import '../../features/units/data/data_source/units_remote_data_source.dart';
import '../../features/units/data/repos/unit_repo_imp.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../../features/auth/domain/auth_repo.dart';
import '../../features/quiz_questions/data/repos/quiz_questions_repo_imp.dart';
import '../../features/exam/data/datasources/exam_remote_data_source.dart';
import '../../features/exam/data/repos/exam_repo_impl.dart';
import '../../features/exam_result/data/repos/exam_result_repo_imp.dart';

import 'firebase_auth_service.dart';
import 'firestore_service.dart';
import 'data_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // 🔐 Auth
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  final firestoreService = FirestoreService();
  getIt.registerSingleton<FirestoreService>(firestoreService);
  getIt.registerSingleton<LocalCacheService>(LocalCacheService());

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      firebaseAuthService: getIt(),
      databaseService: getIt(),
    ),
  );

  // 📚 Quiz
  getIt.registerLazySingleton<QuizHelper>(() => QuizHelper());
  getIt.registerLazySingleton<QuizQuestionsRepoImp>(
    () => QuizQuestionsRepoImp(
      quizQuestionsRemoteDataSource: QuizQuestionsRemoteDataSource(
        databaseService: getIt(),
      ),
      quizQuestionsLocalDataSource: QuizQuestionsLocalDataSourceImp(
        cache: getIt(),
      ),
    ),
  );

  // 📝 Exam
  getIt.registerLazySingleton<ExamsRemoteDataSource>(
    () => ExamsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<ExamRepoImpl>(
    () => ExamRepoImpl(
      examsRemoteDataSource: getIt(),
      examsLocalDataSource: ExamsLocalDataSourceImp(cache: getIt()),
    ),
  );

  // 📝 Exam Questions
  getIt.registerLazySingleton<ExamQuestionsRemoteDataSource>(
    () => ExamQuestionsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<ExamQuestionsRepoImp>(
    () =>
        ExamQuestionsRepoImp(examQuestionsRemoteDataSource: getIt()),
  );

  // 📊 Exam Result
  getIt.registerLazySingleton<ExamResultRepoImp>(
    () => ExamResultRepoImp(
      examResultRemoteDataSourceImp: ExamResultRemoteDataSourceImp(
        databaseService: getIt(),
      ),
      examQuestionsRemoteDataSourceImp: ExamQuestionsRemoteDataSource(
        databaseService: getIt(),
      ),
    ),
  );

  // 📚 Units
  getIt.registerLazySingleton<UnitRepoImpl>(
    () => UnitRepoImpl(
      unitsRemoteDataSource: UnitsRemoteDataSource(
        databaseService: getIt(),
      ),
      unitsLocalDataSource: UnitsLocalDataSourceImpl(cache: getIt()),
    ),
  );

  // 📚 Chapters
  getIt.registerLazySingleton<ChapterRepoImpl>(
    () => ChapterRepoImpl(
      chaptersRemoteDataSource: ChaptersRemoteDataSource(
        databaseService: getIt(),
      ),
      chaptersLocalDataSource: ChaptersLocalDataSourceImpl(
        cache: getIt(),
      ),
    ),
  );

  // 📚 Lessons
  getIt.registerLazySingleton<LessonRepoImp>(
    () => LessonRepoImp(
      lessonsRemoteDataSource: LessonsRemoteDataSource(
        databaseService: getIt(),
      ),
      lessonsLocalDataSource: LessonsLocalDataSourceImpl(
        cache: getIt(),
      ),
    ),
  );
  getIt.registerLazySingleton<QuizRepoImp>(
    () => QuizRepoImp(
      quizzesRemoteDataSource: QuizzesRemoteDataSource(
        databaseService: getIt(),
      ),
      quizzesLocalDataSource: QuizzesLocalDataSourceImpl(
        cache: getIt(),
      ),
    ),
  );

  getIt.registerLazySingleton<UnitsLocalDataSource>(
    () => UnitsLocalDataSourceImpl(cache: getIt<LocalCacheService>()),
  );
  getIt.registerLazySingleton<ChaptersLocalDataSource>(
    () => ChaptersLocalDataSourceImpl(
      cache: getIt<LocalCacheService>(),
    ),
  );
  getIt.registerLazySingleton<LessonsLocalDataSource>(
    () =>
        LessonsLocalDataSourceImpl(cache: getIt<LocalCacheService>()),
  );
  getIt.registerLazySingleton<QuizzesLocalDataSource>(
    () =>
        QuizzesLocalDataSourceImpl(cache: getIt<LocalCacheService>()),
  );
}
