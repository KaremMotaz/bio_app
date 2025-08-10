import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/exam_entity.dart';
import '../../domain/repos/exam_repo.dart';
import '../datasources/exam_remote_data_source.dart';

class ExamRepoImpl implements ExamRepo {
  final ExamRemoteDataSource examRemoteDataSource;

  ExamRepoImpl({required this.examRemoteDataSource});

  @override
  Future<Either<Failure, List<ExamEntity>>> getExams() async {
    try {
      final List<ExamEntity> exam = await examRemoteDataSource
          .fetchExam();

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
          await examRemoteDataSource.fetchExamQuestions(
            examId: examId,
          );

      return Right(questions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitAnswers({
    required String examId,
    required Map<String, dynamic> answers,
  }) async {
    try {
      await examRemoteDataSource.submitAnswers(examId, answers);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
