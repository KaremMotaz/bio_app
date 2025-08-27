import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../auth/domain/user_entity.dart';

abstract class LeaderboardRepo {
  Stream<Either<Failure, List<UserEntity>>> getTop10Now();
  Stream<Either<Failure, List<UserEntity>>> getTop10Week();
  Stream<Either<Failure, List<UserEntity>>> getTop10Month();
}
