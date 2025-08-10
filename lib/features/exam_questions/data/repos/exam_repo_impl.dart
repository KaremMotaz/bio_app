import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
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
}
