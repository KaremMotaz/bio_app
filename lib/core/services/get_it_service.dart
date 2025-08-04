import 'package:bio_app/features/chapters/data/repos/chapter_repo_imp.dart';
import 'package:bio_app/features/lessons/data/repos/lesson_repo_imp.dart';
import 'package:bio_app/features/quiz/domain/logic/quiz_helpers.dart';
import 'package:bio_app/features/units/data/data_source/units_remote_data_source.dart';
import 'package:bio_app/features/units/data/repos/unit_repo_imp.dart';

import '../../features/exam/domain/repos/exam_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../../features/auth/domain/auth_repo.dart';

import '../../features/quiz/data/repos/questions_repo_imp.dart';
import '../../features/exam/data/datasources/exam_remote_data_source.dart';
import '../../features/exam/data/repos/exam_repo_impl.dart';
import '../../features/exam/domain/usecases/get_exam_usecase.dart';
import '../../features/exam/domain/usecases/submit_exam_usecase.dart';

import '../../features/exam_result/data/repos/exam_result_repo_imp.dart';

import 'firebase_auth_service.dart';
import 'firestore_service.dart';
import 'data_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // 🔐 Auth
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      firebaseAuthService: getIt(),
      databaseService: getIt(),
    ),
  );

  // 📚 Quiz
  getIt.registerLazySingleton<QuizHelper>(() => QuizHelper());
  getIt.registerLazySingleton<QuestionsRepoImp>(
    () => QuestionsRepoImp(),
  );

  // 📝 Exam
  getIt.registerLazySingleton<ExamRemoteDataSource>(
    () => ExamRemoteDataSource(firestore: FirebaseFirestore.instance),
  );

  getIt.registerLazySingleton<ExamRepo>(
    () => ExamRepoImpl(examRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<GetExamUseCase>(
    () => GetExamUseCase(examRepo: getIt()),
  );

  getIt.registerLazySingleton<SubmitExamUseCase>(
    () => SubmitExamUseCase(examRepo: getIt()),
  );

  // 📊 Exam Result
  getIt.registerLazySingleton<ExamResultRepoImpl>(
    () => ExamResultRepoImpl(firestore: FirebaseFirestore.instance),
  );

  // 📚 Units
  getIt.registerLazySingleton<UnitRepoImpl>(
    () => UnitRepoImpl(
      unitsRemoteDataSource: UnitsRemoteDataSource(
        databaseService: getIt(),
      ),
    ),
  );

  // 📚 Chapters
  getIt.registerLazySingleton<ChapterRepoImpl>(
    () => ChapterRepoImpl(),
  );

  // 📚 Lessons
  getIt.registerLazySingleton<LessonRepoImp>(() => LessonRepoImp());
}
