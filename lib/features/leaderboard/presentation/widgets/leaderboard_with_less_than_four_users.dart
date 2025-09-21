import 'package:flutter/material.dart';

import '../../../auth/domain/user_entity.dart';
import 'empty_leaderboard_view.dart';
import 'leaderboard_user_badge.dart';
import 'top3_leaderboard_row.dart';

class LeaderboardWithLessThanFourUsers extends StatelessWidget {
  const LeaderboardWithLessThanFourUsers({
    super.key,
    required this.leaderboardList,
    required this.currentTab,
  });

  final List<UserEntity> leaderboardList;
  final String currentTab;

  double getScore(UserEntity user) {
    switch (currentTab) {
      case 'حاليا':
        return user.scoreThisDay ?? 0;
      case 'اسبوعيا':
        return user.scoreThisWeek ?? 0;
      case 'شهريا':
        return user.scoreThisMonth ?? 0;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (leaderboardList.isEmpty) {
      return const EmptyLeaderboardView();
    } else if (leaderboardList.length == 1) {
      return LeaderboardUserBadge(
        leaderboardList: leaderboardList,
        index: 1,
        avatarRadius: 48,
        fontSize: 35,
        outerCircleSize: 110,
        rankCircleSize: 35,
        score: getScore(leaderboardList[0]),
      );
    } else if (leaderboardList.length == 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LeaderboardUserBadge(
              leaderboardList: leaderboardList,
              index: 0,
              avatarRadius: 40,
              fontSize: 35,
              outerCircleSize: 110,
              rankCircleSize: 35,
              score: getScore(leaderboardList[0]),
            ),
            LeaderboardUserBadge(
              leaderboardList: leaderboardList,
              index: 1,
              outerCircleBorderColor: const Color(0xffb5b2b0),
              rankCircleGradientColors: const [
                Color(0xffafafaf),
                Color(0xffced0cf),
              ],
              score: getScore(leaderboardList[1]),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Top3LeaderboardRow(
          leaderboardList: leaderboardList,
          currentTab: currentTab,
        ),
      );
    }
  }
}
