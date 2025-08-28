import '../../../../core/helpers/get_user.dart';
import '../../../auth/domain/user_entity.dart';
import 'leaderboard_card.dart';
import 'package:flutter/material.dart';

class LeaderboardListView extends StatelessWidget {
  const LeaderboardListView({
    super.key,
    required this.leaderboardList,
    required this.currentTab,
  });

  final List<UserEntity> leaderboardList;
  final String currentTab;

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

        final bool isCurrentUser =
            leaderboardList[adjustedIndex].uid == getUser().uid;

        double getScore(UserEntity user, String tab) {
          switch (tab) {
            case 'حاليا':
              return user.scoreThisDay ?? 0;
            case 'اسبوعيا':
              return user.scoreThisWeek ?? 0;
            case 'شهريا':
              return user.scoreThisMonth ?? 0;
            default:
              return 0;
          }
        }

        if (leaderboardList.length > 10 && index == 3) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: LeaderboardCard(
              leaderboardEntity: leaderboardList[adjustedIndex],
              isCurrentUser: isCurrentUser,
              score: getScore(
                leaderboardList[adjustedIndex],
                currentTab,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: LeaderboardCard(
            leaderboardEntity: leaderboardList[adjustedIndex],
            isCurrentUser: isCurrentUser,
            score: getScore(
              leaderboardList[adjustedIndex],
              currentTab,
            ),
          ),
        );
      },
    );
  }
}
