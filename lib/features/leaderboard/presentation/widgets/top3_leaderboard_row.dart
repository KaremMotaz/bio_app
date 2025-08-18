import 'package:bio_app/features/auth/domain/user_entity.dart';
import 'leaderboard_user_badge.dart';
import 'package:flutter/material.dart';

class Top3LeaderboardRow extends StatelessWidget {
  const Top3LeaderboardRow({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LeaderboardUserBadge(
          leaderboardList: leaderboardList,
          index: 1,
          outerCircleBorderColor: const Color(0xffb5b2b0),
          rankCircleGradientColors: const [
            Color(0xffafafaf),
            Color(0xffced0cf),
          ],
          score: getScore(leaderboardList[0]),
        ),
        LeaderboardUserBadge(
          leaderboardList: leaderboardList,
          index: 0,
          avatarRadius: 48,
          fontSize: 35,
          outerCircleSize: 110,
          rankCircleSize: 35,
          score: getScore(leaderboardList[1]),
        ),
        LeaderboardUserBadge(
          leaderboardList: leaderboardList,
          index: 2,
          outerCircleBorderColor: const Color(0xffa88c61),
          rankCircleGradientColors: const [
            Color(0xffad8f56),
            Color(0xffceb995),
          ],
          score: getScore(leaderboardList[2]),
        ),
      ],
    );
  }
}
