import 'dart:developer';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../../exam/data/datasources/exam_questions_remote_data_source.dart';
import '../../../exam/data/datasources/exams_questions_local_data_source.dart';
import '../../../exam/data/models/exam_question_model.dart';
import '../../../exam/domain/entities/exam_question_entity.dart';
import '../datasources/exams_result_local_data_source.dart';
import '../datasources/exams_result_remote_data_source.dart';
import '../models/exams_answers_model.dart';
import 'package:dartz/dartz.dart';
import '../../domin/repos/exam_result_repo.dart';

class ExamResultRepoImp implements ExamResultRepo {
  final ExamsResultRemoteDataSourceImp examResultRemoteDataSourceImp;
  final ExamsQuestionsLocalDataSource examsQuestionsLocalDataSource;
  final ExamsResultLocalDataSource examsResultLocalDataSource;
  final ExamQuestionsRemoteDataSource
  examQuestionsRemoteDataSourceImp;

  ExamResultRepoImp({
    required this.examResultRemoteDataSourceImp,
    required this.examQuestionsRemoteDataSourceImp,
    required this.examsQuestionsLocalDataSource,
    required this.examsResultLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  }) async {
    try {
      // Try to get data from cache first
      final List<ExamQuestionsModel>? cached =
          await examsQuestionsLocalDataSource.getExamsQuestions();
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<ExamQuestionsModel> examsquestions =
          await examQuestionsRemoteDataSourceImp.fetchExamQuestions(
            examId: examId,
          );

      // Cache the data
      await examsQuestionsLocalDataSource.cacheExamsQuestions(
        examsquestions,
      );

      return Right(examsquestions);
    } catch (e) {
      log('Error fetching exam questions: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExamsAnswersModel>>>
  getStudentAnswers() async {
    try {
      // Try to get data from cache first
      final List<ExamsAnswersModel>? cached =
          await examsResultLocalDataSource.getExamsResult();
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<ExamsAnswersModel> examsAnswers =
          await examResultRemoteDataSourceImp.getStudentAnswers();

      // Cache the data
      await examsResultLocalDataSource.cacheExamsResult(
        examsResults: examsAnswers,
      );

      return Right(examsAnswers);
    } catch (e) {
      log('Error fetching student answers: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }
}
