import 'package:flutter/material.dart';

import '../../../exam/presentation/views/available_exams_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../leaderboard/presentation/views/leaderboard_view.dart';
import '../../../settings/presentation/views/settings_view.dart';

class MainPageView extends StatelessWidget {
  final PageController controller;
  final Function(int) onPageChanged;

  const MainPageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: [
        const HomeView(),
        const AvailableExamsView(),
        const LeaderboardView(),
        const SettingsView(),
      ],
    );
  }
}
