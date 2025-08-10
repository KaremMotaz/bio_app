import 'dart:developer';

import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/exam_questions/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam_questions/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam_result/data/datasources/exam_result_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../domin/repos/exam_result_repo.dart';

class ExamResultRepoImpl implements ExamResultRepo {
  final ExamResultRemoteDataSourceImp examResultRemoteDataSourceImp;

  ExamResultRepoImpl({required this.examResultRemoteDataSourceImp});

  @override
  Future<Either<Failure, List<ExamEntity>>> getExams() async {
    try {
      final List<ExamEntity> exam =
          await examResultRemoteDataSourceImp.fetchExam();

      return Right(exam);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  }) async {
    try {
      final List<ExamQuestionEntity> questions =
          await examResultRemoteDataSourceImp.fetchExamQuestions(
            examId: examId,
          );

      return Right(questions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, int>>>>
  getStudentAnswers() async {
    try {
      final List<Map<String, int>> answers =
          await examResultRemoteDataSourceImp.getStudentAnswers();

      return Right(answers);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
