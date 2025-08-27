import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/server_failure.dart';
import '../../../core/helpers/backend_endpoint.dart';
import '../../../core/services/data_service.dart';
import '../../auth/domain/user_entity.dart';
import '../domain/leaderboard_repo.dart';

class LeaderboardRepoImp implements LeaderboardRepo {
  final DatabaseService databaseService;

  LeaderboardRepoImp({required this.databaseService});

  @override
  Stream<Either<Failure, List<UserEntity>>> getTop10Now() {
    return databaseService
        .streamCollection(
          path: BackendEndpoint.getLeaderboardData,
          orderBy: "scoreThisDay",
          descending: true,
          limit: 10,
        )
        .map<Either<Failure, List<UserEntity>>>((
          QuerySnapshot snapshot,
        ) {
          try {
            final users = snapshot.docs.asMap().entries.map((entry) {
              final index = entry.key;
              final doc = entry.value;
              return UserEntity(
                uid: doc.id,
                firstName: doc["firstName"],
                lastName: doc["lastName"],
                imageUrl: doc["imageUrl"],
                avatarColor: doc["avatarColor"],
                scoreThisDay: (doc["scoreThisDay"] ?? 0),
                rank: index + 1,
              );
            }).toList();
            return Right<Failure, List<UserEntity>>(users);
          } catch (e) {
            return Left(ServerFailure(message: e.toString()));
          }
        });
  }

  @override
  Stream<Either<Failure, List<UserEntity>>> getTop10Week() {
    return databaseService
        .streamCollection(
          path: BackendEndpoint.getLeaderboardData,
          orderBy: "scoreThisWeek",
          descending: true,
          limit: 10,
        )
        .map<Either<Failure, List<UserEntity>>>((
          QuerySnapshot snapshot,
        ) {
          try {
            final users = snapshot.docs.asMap().entries.map((entry) {
              final index = entry.key;
              final doc = entry.value;
              return UserEntity(
                uid: doc.id,
                firstName: doc["firstName"],
                lastName: doc["lastName"],
                imageUrl: doc["imageUrl"],
                avatarColor: doc["avatarColor"],
                scoreThisWeek: (doc["scoreThisWeek"] ?? 0),
                rank: index + 1,
              );
            }).toList();
            return Right<Failure, List<UserEntity>>(users);
          } catch (e) {
            return Left(ServerFailure(message: e.toString()));
          }
        });
  }

  @override
  Stream<Either<Failure, List<UserEntity>>> getTop10Month() {
    return databaseService
        .streamCollection(
          path: BackendEndpoint.getLeaderboardData,
          orderBy: "scoreThisMonth",
          descending: true,
          limit: 10,
        )
        .map<Either<Failure, List<UserEntity>>>((
          QuerySnapshot snapshot,
        ) {
          try {
            final users = snapshot.docs.asMap().entries.map((entry) {
              final index = entry.key;
              final doc = entry.value;
              return UserEntity(
                uid: doc.id,
                firstName: doc["firstName"],
                lastName: doc["lastName"],
                imageUrl: doc["imageUrl"],
                avatarColor: doc["avatarColor"],
                scoreThisMonth: (doc["scoreThisMonth"] ?? 0),
                rank: index + 1,
              );
            }).toList();
            return Right<Failure, List<UserEntity>>(users);
          } catch (e) {
            return Left(ServerFailure(message: e.toString()));
          }
        });
  }
}
