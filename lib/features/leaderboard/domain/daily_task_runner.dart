import 'package:intl/intl.dart';

import '../../../core/services/cache_helper.dart';
import 'leaderboard_repo.dart';

class DailyTaskRunner {
  final LeaderboardRepo leaderboardRepo;

  DailyTaskRunner({required this.leaderboardRepo});

  Future<void> runDailyTasks() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final lastRunDate = CacheHelper.getString(
      key: 'last_daily_run_date',
    );

    if (lastRunDate != today) {
      await leaderboardRepo.resetUsersOnLeaderboard();
      await CacheHelper.set(key: 'last_daily_run_date', value: today);
    }
  }
}
