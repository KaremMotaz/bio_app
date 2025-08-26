import 'dart:developer';

import 'package:bio_app/core/sync/exam_view_open.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/repos/exam_repo.dart';
import '../datasources/exam_remote_data_source.dart';
import '../datasources/exams_local_data_source.dart';
import '../models/exam_model.dart';

class ExamRepoImpl implements ExamRepo {
  final ExamsRemoteDataSource examsRemoteDataSource;
  final ExamsLocalDataSource examsLocalDataSource;

  ExamRepoImpl({
    required this.examsRemoteDataSource,
    required this.examsLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ExamEntity>>> getExams() async {
    try {
      await ExamViewOpen.instance.runOnce();

      // Try to get data from cache first
      final List<ExamModel>? cached = await examsLocalDataSource
          .getExams();
      log("from exams repo impl $cached");

      if (cached != null && cached.isNotEmpty) {
        log("from exams repo impl22232323 $cached");
        return Right(cached);
      }
      //  No data in cache, fetch from remote
      final List<ExamModel> exams = await examsRemoteDataSource
          .getExams();

      await examsLocalDataSource.clearExams();
      // Cache the data
      await examsLocalDataSource.cacheExams(exams);
      log("from exams repo impl2222 $exams");

      return Right(exams);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> markExamAsOpened({
    required String examId,
  }) async {
    try {
      await examsRemoteDataSource.markExamAsOpened(examId: examId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, bool>>>
  getOpenedExamsStatus() async {
    try {
      final Map<String, bool> result = await examsRemoteDataSource
          .getOpenedExamsStatus();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
