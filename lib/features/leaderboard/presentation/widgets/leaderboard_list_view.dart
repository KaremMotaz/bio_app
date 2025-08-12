import 'package:bio_app/features/leaderboard/domain/leaderboard_entity.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/leaderboard_card.dart';
import 'package:flutter/material.dart';

class LeaderboardListView extends StatelessWidget {
  const LeaderboardListView({
    super.key,
    required this.leaderboardList,
  });

  final List<LeaderboardEntity> leaderboardList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: leaderboardList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: LeaderboardCard(
              leaderboardEntity: leaderboardList[index],
            ),
          );
        },
      ),
    );
  }
}
