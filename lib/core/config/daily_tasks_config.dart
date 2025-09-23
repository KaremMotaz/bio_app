import '../services/get_it_service.dart';
import '../../features/leaderboard/domain/daily_task_runner.dart';
import '../../features/leaderboard/domain/leaderboard_repo.dart';

class DailyTasksConfig {
  static Future<void> init() async {
    final leaderboardRepo = getIt<LeaderboardRepo>();
    final dailyTaskRunner = DailyTaskRunner(
      leaderboardRepo: leaderboardRepo,
    );

    await dailyTaskRunner.runDailyTasks();

  }
}
