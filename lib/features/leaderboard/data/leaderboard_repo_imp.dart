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
        .map<Either<Failure, List<UserEntity>>>((snapshot) {
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
                scoreThisDay:
                    (doc["scoreThisDay"] as num?)?.toDouble() ?? 0.0,
                rank: index + 1,
              );
            }).toList();
            return Right(users);
          } catch (e) {
            return const Left(
              ServerFailure(
                message: "Failed to fetch daily leaderboard",
              ),
            );
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
        .map<Either<Failure, List<UserEntity>>>((snapshot) {
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
                scoreThisWeek:
                    (doc["scoreThisWeek"] as num?)?.toDouble() ?? 0.0,
                rank: index + 1,
              );
            }).toList();
            return Right(users);
          } catch (e) {
            return const Left(
              ServerFailure(
                message: "Failed to fetch weekly leaderboard",
              ),
            );
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
        .map<Either<Failure, List<UserEntity>>>((snapshot) {
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
                scoreThisMonth:
                    (doc["scoreThisMonth"] as num?)?.toDouble() ??
                    0.0,
                rank: index + 1,
              );
            }).toList();
            return Right(users);
          } catch (e) {
            return const Left(
              ServerFailure(
                message: "Failed to fetch monthly leaderboard",
              ),
            );
          }
        });
  }

  @override
  Future<void> resetUsersOnLeaderboard() async {
    try {
      final now = DateTime.now();
      final todayKey = "${now.year}-${now.month}-${now.day}";
      final weekKey = "${now.year}-W${_weekNumber(now)}";
      final monthKey = "${now.year}-${now.month}";

      const metadataPath = "metadata/leaderboard";
      final settings =
          await databaseService.getData(path: metadataPath) ?? {};

      final lastDailyReset = settings["lastDailyReset"];
      final lastWeeklyReset = settings["lastWeeklyReset"];
      final lastMonthlyReset = settings["lastMonthlyReset"];

      // Daily
      if (lastDailyReset != todayKey) {
        final users =
            await databaseService.getData(
                  path: BackendEndpoint.getUserData,
                  orderBy: "scoreThisDay",
                  descending: true,
                )
                as List;

        for (var user in users) {
          await databaseService.updateData(
            path: "${BackendEndpoint.updateUserData}/${user["id"]}",
            data: {"scoreThisDay": 0.0},
          );
        }
        await databaseService.updateData(
          path: metadataPath,
          data: {"lastDailyReset": todayKey},
        );
      }

      // Weekly
      if (lastWeeklyReset != weekKey) {
        final users =
            await databaseService.getData(
                  path: BackendEndpoint.getUserData,
                  orderBy: "scoreThisWeek",
                  descending: true,
                )
                as List;

        for (var user in users) {
          await databaseService.updateData(
            path: "${BackendEndpoint.updateUserData}/${user["id"]}",
            data: {"scoreThisWeek": 0.0},
          );
        }
        await databaseService.updateData(
          path: metadataPath,
          data: {"lastWeeklyReset": weekKey},
        );
      }

      // Monthly
      if (lastMonthlyReset != monthKey) {
        final users =
            await databaseService.getData(
                  path: BackendEndpoint.getUserData,
                  orderBy: "scoreThisMonth",
                  descending: true,
                )
                as List;

        for (var user in users) {
          await databaseService.updateData(
            path: "${BackendEndpoint.updateUserData}/${user["id"]}",
            data: {"scoreThisMonth": 0.0},
          );
        }
        await databaseService.updateData(
          path: metadataPath,
          data: {"lastMonthlyReset": monthKey},
        );
      }
    } catch (e) {
      throw const ServerFailure(
        message: "Failed to reset leaderboard",
      );
    }
  }

  int _weekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final diff = date.difference(firstDayOfYear);
    return ((diff.inDays + firstDayOfYear.weekday) / 7).ceil();
  }
}
