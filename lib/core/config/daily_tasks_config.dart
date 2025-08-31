import 'package:bio_app/core/services/get_it_service.dart';
import 'package:bio_app/features/leaderboard/domain/daily_task_runner.dart';
import 'package:bio_app/features/leaderboard/domain/leaderboard_repo.dart';

class DailyTasksConfig {
  static Future<void> init() async {
    final leaderboardRepo = getIt<LeaderboardRepo>();
    final dailyTaskRunner = DailyTaskRunner(
      leaderboardRepo: leaderboardRepo,
    );

    await dailyTaskRunner.runDailyTasks();

  }
}
