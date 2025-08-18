import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/auth/domain/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LeaderboardRepo {
  Stream<Either<Failure, List<UserEntity>>> getTop10Now();
  Stream<Either<Failure, List<UserEntity>>> getTop10Week();
  Stream<Either<Failure, List<UserEntity>>> getTop10Month();
}
