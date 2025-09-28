import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../auth/domain/user_entity.dart';
import 'leaderboard_list_view.dart';
import 'leaderboard_with_less_than_four_users.dart';
import 'top3_leaderboard_row.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({
    super.key,
    required this.leaderboardList,
    required this.currentTab,
    this.isLoading = false,
  });
  final List<UserEntity> leaderboardList;
  final String currentTab;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    if (leaderboardList.length < 4) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Skeletonizer(
            enabled: isLoading,
            child: LeaderboardWithLessThanFourUsers(
              leaderboardList: leaderboardList,
              currentTab: currentTab,
            ),
          ),
        ],
      );
    }
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
            Skeletonizer(
              enabled: isLoading,
              child: LeaderboardListView(
                leaderboardList: leaderboardList,
                currentTab: currentTab,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
