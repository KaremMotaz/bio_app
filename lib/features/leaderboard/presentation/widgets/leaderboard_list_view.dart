import '../../domain/leaderboard_entity.dart';
import 'leaderboard_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaderboardListView extends StatelessWidget {
  const LeaderboardListView({
    super.key,
    required this.leaderboardList,
  });

  final List<LeaderboardEntity> leaderboardList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: leaderboardList.length > 3
          ? leaderboardList.length - 3
          : 0,
      itemBuilder: (context, index) {
        final int adjustedIndex = index + 3;
        final String currentUser =
            FirebaseAuth.instance.currentUser!.uid;
        final bool isCurrentUser =
            leaderboardList[adjustedIndex].id == currentUser;

        if (leaderboardList.length > 10 && index == 3) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: LeaderboardCard(
              leaderboardEntity: leaderboardList[adjustedIndex],
              isCurrentUser: isCurrentUser,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: LeaderboardCard(
            leaderboardEntity: leaderboardList[adjustedIndex],
            isCurrentUser: isCurrentUser,
          ),
        );
      },
    );
  }
}
