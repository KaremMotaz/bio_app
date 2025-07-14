import 'package:flutter/material.dart';
import 'package:bio_app/features/exam/presentation/views/exam_view.dart';
import 'package:bio_app/features/home/presentation/views/home_view.dart';
import 'package:bio_app/features/leaderboard/presentation/views/leaderboard_view.dart';
import 'package:bio_app/features/settings/presentation/views/settings_view.dart';

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
        const ExamView(),
        const LeaderboardView(),
        const SettingsView(),
      ],
    );
  }
}
