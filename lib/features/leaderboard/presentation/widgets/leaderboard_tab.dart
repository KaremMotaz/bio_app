import 'package:bio_app/features/leaderboard/domain/leaderboard_entity.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/leaderboard_list_view.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/top3_leaderboard_row.dart';
import 'package:flutter/material.dart';

class NowLeaderboardTab extends StatelessWidget {
  const NowLeaderboardTab({
    super.key,
    required this.nowLeaderboardList,
  });
  final List<LeaderboardEntity> nowLeaderboardList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Top3LeaderboardRow(leaderboardList: nowLeaderboardList),
          const SizedBox(height: 10),
          LeaderboardListView(leaderboardList: nowLeaderboardList),
        ],
      ),
    );
  }
}
