import 'package:bio_app/features/auth/domain/user_entity.dart';
import 'leaderboard_list_view.dart';
import 'top3_leaderboard_row.dart';
import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({
    super.key,
    required this.leaderboardList,
    required this.currentTab,
  });
  final List<UserEntity> leaderboardList;
  final String currentTab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Top3LeaderboardRow(
              leaderboardList: leaderboardList,
              currentTab: currentTab,
            ),
            const SizedBox(height: 10),
            LeaderboardListView(
              leaderboardList: leaderboardList,
              currentTab: currentTab,
            ),
          ],
        ),
      ),
    );
  }
}
