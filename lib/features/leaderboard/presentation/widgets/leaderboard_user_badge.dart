import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class LeaderboardUserBadge extends StatelessWidget {
  const LeaderboardUserBadge({
    super.key,
    required this.nowLeaderboardList,
    required this.index,
    this.avatarRadius = 38,
    this.outerCircleSize = 90,
    this.rankCircleSize = 28,
    this.outerCircleBorderColor = const Color(0xfff6bb14),
    this.rankCircleGradientColors = const [
      Color(0xfffdbe00),
      Color(0xfffad75a),
    ],
  });

  final List<Map<String, dynamic>> nowLeaderboardList;
  final int index;
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
          visible: nowLeaderboardList[index]['rank'] == 1,
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
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(
                nowLeaderboardList[index]['avatarUrl'],
              ),
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
                  "${nowLeaderboardList[index]['rank']}",
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
          "${nowLeaderboardList[index]['name']}",
          style: TextStyles.bold16.copyWith(color: Colors.black),
        ),
        Text(
          "${nowLeaderboardList[index]['score']}",
          style: TextStyles.bold14.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
