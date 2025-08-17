import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../domain/leaderboard_entity.dart';
import 'package:flutter/material.dart';

class LeaderboardUserBadge extends StatelessWidget {
  const LeaderboardUserBadge({
    super.key,
    required this.leaderboardList,
    required this.index,
    this.avatarRadius = 38,
    this.outerCircleSize = 90,
    this.rankCircleSize = 28,
    this.outerCircleBorderColor = const Color(0xfff6bb14),
    this.rankCircleGradientColors = const [
      Color(0xfffdbe00),
      Color(0xfffad75a),
    ],
    this.fontSize = 25,
  });

  final List<LeaderboardEntity> leaderboardList;
  final int index;
  final double? fontSize;
  final double avatarRadius;
  final double outerCircleSize;
  final double rankCircleSize;
  final Color outerCircleBorderColor;
  final List<Color> rankCircleGradientColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: leaderboardList[index].rank == 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Column(
            children: [
              Image.asset(AssetsData.crownIcon, width: 30),
              const SizedBox(height: 2),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: outerCircleSize,
              height: outerCircleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: outerCircleBorderColor,
                  width: 4,
                ),
              ),
            ),
            UserAvatar(
              name: leaderboardList[index].name,
              savedColor: leaderboardList[index].savedColor,
              imageUrl: leaderboardList[index].avatarUrl,
              radius: avatarRadius,
              fontSize: fontSize,
            ),
            Positioned(
              bottom: -rankCircleSize / 3,
              child: Container(
                alignment: Alignment.center,
                width: rankCircleSize,
                height: rankCircleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: rankCircleGradientColors,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  border: Border.all(
                    color: outerCircleBorderColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  "${leaderboardList[index].rank}",
                  style: TextStyles.bold16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          leaderboardList[index].name,
          style: TextStyles.bold16.copyWith(color: Colors.black),
        ),
        Text(
          "${leaderboardList[index].score}",
          style: TextStyles.bold14.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
