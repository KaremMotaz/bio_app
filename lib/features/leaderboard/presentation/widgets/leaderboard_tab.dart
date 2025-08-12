import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/leaderboard_user_badge.dart';
import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    final userRow = {
      'id': "dfgshfdjg",
      'name': "Karim Motaz",
      'score': 100,
      'rank': 1,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(AssetsData.profileImage),
              ),
              LeaderboardUserBadge(userRow: userRow),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(AssetsData.profileImage),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

