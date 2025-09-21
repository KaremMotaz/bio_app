import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../auth/domain/user_entity.dart';

class LeaderboardUserBadge extends StatelessWidget {
  const LeaderboardUserBadge({
    super.key,
    required this.leaderboardList,
    required this.index,
    this.avatarRadius = 38,
    this.outerCircleSize = 90,
    this.rankCircleSize = 28,
    this.outerCircleBorderColor = const Color(0xffFCC432),
    this.rankCircleGradientColors = const [
      Color(0xffFCC432),
      Color(0xfffad75a),
    ],
    this.fontSize = 25,
    this.borderWidth = 3,
    required this.score,
  });

  final List<UserEntity> leaderboardList;
  final int index;
  final double? fontSize;
  final double avatarRadius;
  final double outerCircleSize;
  final double rankCircleSize;
  final Color outerCircleBorderColor;
  final List<Color> rankCircleGradientColors;
  final double score;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: leaderboardList[index].rank == 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Transform.translate(
            offset: const Offset(0, 3),
            child: Image.asset(AssetsData.crownIcon, width: 40),
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
                color: AppColors.white,
                border: Border.all(
                  color: outerCircleBorderColor,
                  width: borderWidth,
                ),
              ),
            ),
            UserAvatar(
              name:
                  "${leaderboardList[index].firstName} ${leaderboardList[index].lastName}",
              savedColor: leaderboardList[index].avatarColor!,
              imageUrl: leaderboardList[index].imageUrl,
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
                    color: AppColors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  "${leaderboardList[index].rank}",
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          "${leaderboardList[index].firstName} ${leaderboardList[index].lastName}",
          style: TextStyles.bold16.copyWith(color: AppColors.black),
        ),
        Text(
          "${score.toInt()}",
          textDirection: TextDirection.ltr,
          style: TextStyles.bold14.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
