import 'package:bio_app/features/exam/data/repos/exam_repo_impl.dart';
import 'package:bio_app/features/exam/presentation/manager/exams_cubit/exams_cubit.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../units/data/repos/unit_repo_imp.dart';
import '../../../units/presentation/manager/unit_cubit/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../exam/presentation/views/exams_view.dart';
import '../../../units/presentation/unit_view.dart';
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
        BlocProvider(
          create: (context) =>
              UnitCubit(unitRepoImpl: getIt<UnitRepoImpl>())
                ..getUnits(),
          child: const UnitView(),
        ),
        BlocProvider(
          create: (context) =>
              ExamsCubit(examRepoImpl: getIt<ExamRepoImpl>())..getExams(),
          child: const ExamsView(),
        ),
        const LeaderboardView(),
        const SettingsView(),
      ],
    );
  }
}
