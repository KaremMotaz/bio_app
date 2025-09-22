import 'package:bio_app/features/quiz_questions/presentation/manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import 'package:bio_app/features/settings/data/settings_data_source.dart';
import 'package:bio_app/features/settings/data/settings_repo.dart';

import '../../features/lessons/data/data_source/quizzes_remote_data_source.dart';
import '../../features/lessons/data/repos/quiz_repo_imp.dart';
import '../../features/quiz_questions/data/data_source/quiz_questions_local_data_source.dart';
import '../../features/quiz_questions/data/models/quiz_question_model.dart';

import '../../features/exam/data/datasources/exams_local_data_source.dart';
import '../../features/exam/domain/repos/exam_repo.dart';
import '../../features/exam/domain/usecases/filter_published_results_exams.dart';
import '../../features/exam/domain/usecases/filter_visible_exams.dart';

import 'local_cache_service.dart';
import '../../features/chapters/data/models/chapter_model.dart';
import '../../features/exam/data/models/exam_model.dart';
import '../../features/exam/data/models/exam_question_model.dart';
import '../../features/exam_result/data/models/exams_answers_model.dart';
import '../../features/leaderboard/data/leaderboard_repo_imp.dart';
import '../../features/leaderboard/domain/leaderboard_repo.dart';
import '../../features/lessons/data/models/lesson_model.dart';
import '../../features/lessons/data/models/quiz_model.dart';

import '../../features/units/data/models/unit_model.dart';

import 'storage_service.dart';
import 'supabase_storage_service.dart';
import '../../features/profile/data/repos/images_repo_imp.dart';
import '../../features/profile/data/repos/user_data_repo_imp.dart';
import '../../features/profile/domain/repos/images_repo.dart';

import '../../features/exam/data/datasources/exam_questions_remote_data_source.dart';
import '../../features/exam/data/datasources/exams_local_data_source_imp.dart';
import '../../features/exam/data/datasources/exams_questions_local_data_source_imp.dart';
import '../../features/exam/data/repos/exam_questions_repo_impl.dart';
import '../../features/exam_result/data/datasources/exams_result_local_data_source_imp.dart';
import '../../features/exam_result/data/datasources/exams_result_remote_data_source.dart';
import '../../features/quiz_questions/data/data_source/quiz_questions_local_data_source_imp.dart';
import '../../features/quiz_questions/data/data_source/quiz_questions_remote_data_source.dart';

import '../../features/chapters/data/data_source/chapters_local_data_source.dart';
import '../../features/lessons/data/data_source/lessons_local_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_local_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_local_data_source_imp.dart';
import '../../features/units/data/data_source/units_local_data_source.dart';
import '../../features/chapters/data/data_source/chapters_local_data_source_imp.dart';
import '../../features/chapters/data/data_source/chapters_remote_data_source.dart';
import '../../features/chapters/data/repos/chapter_repo_imp.dart';
import '../../features/lessons/data/data_source/lessons_local_data_source_imp.dart';
import '../../features/lessons/data/data_source/lessons_remote_data_source.dart';
import '../../features/lessons/data/repos/lesson_repo_imp.dart';
import '../../features/quiz_questions/domain/helper/quiz_helpers.dart';
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
  getIt.registerSingleton<DatabaseService>(FirestoreService());

  getIt.registerSingleton<FirebaseAuthService>(
    FirebaseAuthService(databaseService: getIt()),
  );
  final firestoreService = FirestoreService();
  getIt.registerSingleton<FirestoreService>(firestoreService);

  getIt.registerSingleton<LocalCacheService<QuizModel>>(
    LocalCacheService<QuizModel>(),
  );
  getIt.registerSingleton<LocalCacheService<QuizQuestionModel>>(
    LocalCacheService<QuizQuestionModel>(),
  );
  getIt.registerSingleton<LocalCacheService<LessonModel>>(
    LocalCacheService<LessonModel>(),
  );
  getIt.registerSingleton<LocalCacheService<ChapterModel>>(
    LocalCacheService<ChapterModel>(),
  );
  getIt.registerSingleton<LocalCacheService<UnitModel>>(
    LocalCacheService<UnitModel>(),
  );
  getIt.registerSingleton<LocalCacheService<ExamModel>>(
    LocalCacheService<ExamModel>(),
  );
  getIt.registerSingleton<LocalCacheService<ExamQuestionsModel>>(
    LocalCacheService<ExamQuestionsModel>(),
  );
  getIt.registerSingleton<LocalCacheService<ExamsAnswersModel>>(
    LocalCacheService<ExamsAnswersModel>(),
  );

  getIt.registerLazySingleton<QuizQuestionAnswerModel>(
    () => const QuizQuestionAnswerModel(
      isSelected: true,
      selectedAnswers: {},
    ),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      firebaseAuthService: getIt(),
      databaseService: getIt(),
    ),
  );
  getIt.registerLazySingleton<StorageService>(
    () => SupabaseStorageService(),
  );
  getIt.registerLazySingleton<ImagesRepo>(
    () => ImagesRepoImp(
      storageService: getIt(),
      firestoreService: getIt(),
    ),
  );

  getIt.registerLazySingleton<UserDataRepoImp>(
    () => UserDataRepoImp(databaseService: getIt()),
  );

  // 📝 Exam
  getIt.registerLazySingleton<ExamsRemoteDataSource>(
    () => ExamsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<ExamsLocalDataSource>(
    () => ExamsLocalDataSourceImp(
      cache: getIt<LocalCacheService<ExamModel>>(),
    ),
  );

  getIt.registerLazySingleton<ExamRepo>(
    () => ExamRepoImpl(
      examsRemoteDataSource: getIt(),
      examsLocalDataSource: ExamsLocalDataSourceImp(cache: getIt()),
    ),
  );
  getIt.registerLazySingleton<ExamRepoImpl>(
    () => ExamRepoImpl(
      examsRemoteDataSource: getIt(),
      examsLocalDataSource: ExamsLocalDataSourceImp(cache: getIt()),
    ),
  );

  getIt.registerLazySingleton<FilterVisibleExams>(
    () => FilterVisibleExams(examRepoImpl: getIt()),
  );
  getIt.registerLazySingleton<FilterPublishedResultsExams>(
    () => FilterPublishedResultsExams(examRepo: getIt()),
  );

  // 📝 Exam Questions
  getIt.registerLazySingleton<ExamQuestionsRemoteDataSource>(
    () => ExamQuestionsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<ExamQuestionsRepoImp>(
    () => ExamQuestionsRepoImp(
      examQuestionsRemoteDataSource: getIt(),
      examsQuestionsLocalDataSource: ExamsQuestionsLocalDataSourceImp(
        cache: getIt(),
      ),
    ),
  );

  // 📊 Exam Result
  getIt.registerLazySingleton<ExamResultRepoImp>(
    () => ExamResultRepoImp(
      examResultRemoteDataSourceImp: ExamsResultRemoteDataSourceImp(
        databaseService: getIt(),
      ),
      examQuestionsRemoteDataSourceImp: ExamQuestionsRemoteDataSource(
        databaseService: getIt(),
      ),
      examsQuestionsLocalDataSource: ExamsQuestionsLocalDataSourceImp(
        cache: getIt(),
      ),
      examsResultLocalDataSource: ExamsResultLocalDataSourceImp(
        cache: getIt(),
      ),
    ),
  );

  // 📚 Units
  getIt.registerLazySingleton<UnitsRemoteDataSource>(
    () => UnitsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<UnitsLocalDataSource>(
    () => UnitsLocalDataSourceImpl(
      cache: getIt<LocalCacheService<UnitModel>>(),
    ),
  );

  getIt.registerLazySingleton<UnitRepoImpl>(
    () => UnitRepoImpl(
      unitsRemoteDataSource: getIt(),
      unitsLocalDataSource: getIt(),
    ),
  );

  // 📚 Chapters
  getIt.registerLazySingleton<ChaptersRemoteDataSource>(
    () => ChaptersRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<ChaptersLocalDataSource>(
    () => ChaptersLocalDataSourceImpl(
      cache: getIt<LocalCacheService<ChapterModel>>(),
    ),
  );

  getIt.registerLazySingleton<ChapterRepoImpl>(
    () => ChapterRepoImpl(
      chaptersRemoteDataSource: getIt(),
      chaptersLocalDataSource: getIt(),
    ),
  );

  // 📚 Lessons
  getIt.registerLazySingleton<LessonsRemoteDataSource>(
    () => LessonsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<LessonsLocalDataSource>(
    () => LessonsLocalDataSourceImpl(
      cache: getIt<LocalCacheService<LessonModel>>(),
    ),
  );

  getIt.registerLazySingleton<LessonRepoImp>(
    () => LessonRepoImp(
      lessonsRemoteDataSource: getIt(),
      lessonsLocalDataSource: getIt(),
    ),
  );

  // 📚 Quizzes
  getIt.registerLazySingleton<QuizHelper>(() => QuizHelper());

  getIt.registerLazySingleton<QuizzesRemoteDataSource>(
    () => QuizzesRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<QuizzesLocalDataSource>(
    () => QuizzesLocalDataSourceImpl(
      cache: getIt<LocalCacheService<QuizModel>>(),
    ),
  );

  getIt.registerLazySingleton<QuizRepoImp>(
    () => QuizRepoImp(
      quizzesRemoteDataSource: getIt(),
      quizzesLocalDataSource: getIt(),
    ),
  );

  // 📚 Quiz Questions
  getIt.registerLazySingleton<QuizQuestionsRemoteDataSource>(
    () => QuizQuestionsRemoteDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<QuizQuestionsLocalDataSource>(
    () => QuizQuestionsLocalDataSourceImp(
      cache: getIt<LocalCacheService<QuizQuestionModel>>(),
    ),
  );

  getIt.registerLazySingleton<QuizQuestionsRepoImp>(
    () => QuizQuestionsRepoImp(
      quizQuestionsRemoteDataSource: getIt(),
      quizQuestionsLocalDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<LeaderboardRepo>(
    () => LeaderboardRepoImp(databaseService: getIt()),
  );

  getIt.registerLazySingleton<SettingsDataSource>(
    () => SettingsDataSource(databaseService: getIt()),
  );

  getIt.registerLazySingleton<SettingsRepo>(
    () => SettingsRepo(dataSource: getIt()),
  );
}
