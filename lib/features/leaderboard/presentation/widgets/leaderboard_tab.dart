import 'package:bio_app/features/leaderboard/domain/leaderboard_entity.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/leaderboard_list_view.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/top3_leaderboard_row.dart';
import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key, required this.nowLeaderboardList});
  final List<LeaderboardEntity> nowLeaderboardList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Top3LeaderboardRow(leaderboardList: nowLeaderboardList),
            const SizedBox(height: 10),
            LeaderboardListView(leaderboardList: nowLeaderboardList),
          ],
        ),
      ),
    );
  }
}
