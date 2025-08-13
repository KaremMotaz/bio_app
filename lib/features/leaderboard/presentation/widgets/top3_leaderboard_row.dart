import 'package:bio_app/features/leaderboard/domain/leaderboard_entity.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/leaderboard_user_badge.dart';
import 'package:flutter/material.dart';

class Top3LeaderboardRow extends StatelessWidget {
  const Top3LeaderboardRow({
    super.key,
    required this.leaderboardList,
  });
  final List<LeaderboardEntity> leaderboardList;

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
        ),
        LeaderboardUserBadge(
          leaderboardList: leaderboardList,
          index: 0,
          avatarRadius: 48,
          fontSize: 35,
          outerCircleSize: 110,
          rankCircleSize: 35,
        ),
        LeaderboardUserBadge(
          leaderboardList: leaderboardList,
          index: 2,
          outerCircleBorderColor: const Color(0xffa88c61),
          rankCircleGradientColors: const [
            Color(0xffad8f56),
            Color(0xffceb995),
          ],
        ),
      ],
    );
  }
}
