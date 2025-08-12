import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/leaderboard/data/mock_leaderboard.dart';
import 'package:bio_app/features/leaderboard/presentation/widgets/top3_leaderboard_row.dart';
import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Top3LeaderboardRow(leaderboardList: nowLeaderboardList),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(right: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffe8f9f9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xffe8f9f9),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Text("4", style: TextStyles.semiBold15),
                    Icon(
                      Icons.arrow_drop_up,
                      size: 35,
                      color: Color(0xfff6bb14),
                    ),
                  ],
                ),
                Expanded(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        AssetsData.profile1,
                      ),
                      radius: 25,
                    ),
                    title: const Text("Karim Motaz"),
                    trailing: SizedBox(
                      height: 35,
                      width: 60,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xffd7e4e5),
                        ),
                        child: const Text(
                          "915",
                          style: TextStyles.semiBold15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
