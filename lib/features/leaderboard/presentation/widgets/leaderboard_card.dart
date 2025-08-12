import 'package:bio_app/features/leaderboard/domain/leaderboard_entity.dart';
import 'package:flutter/material.dart';
import 'package:bio_app/core/theming/text_styles.dart';

class LeaderboardCard extends StatelessWidget {
  final LeaderboardEntity leaderboardEntity;

  const LeaderboardCard({super.key, required this.leaderboardEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffe8f9f9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffe8f9f9), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, 15),
                    child: Text(
                      leaderboardEntity.rank.toString(),
                      style: TextStyles.semiBold18,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(2, 0),
                    child: const Icon(
                      Icons.arrow_drop_up_rounded,
                      size: 40,
                      color: Color(0xfff6bb14),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      leaderboardEntity.avatarUrl,
                    ),
                    radius: 25,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    leaderboardEntity.name,
                    style: TextStyles.semiBold15,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffd7e4e5),
            ),
            child: Text(
              leaderboardEntity.score.toString(),
              style: TextStyles.semiBold15,
            ),
          ),
        ],
      ),
    );
  }
}
