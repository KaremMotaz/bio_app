import '../../../exam/domain/repos/exam_repo.dart';
import '../../../exam/domain/usecases/filter_published_results_exams.dart';
import '../../../exam/domain/usecases/filter_visible_exams.dart';

import '../../../leaderboard/domain/leaderboard_repo.dart';
import '../../../leaderboard/presentation/manager/leaderboard_cubit/leaderboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../exam/presentation/manager/exams_cubit/exams_cubit.dart';
import '../../../exam/presentation/views/exams_view.dart';
import '../../../leaderboard/presentation/views/leaderboard_view.dart';
import '../../../settings/presentation/views/settings_view.dart';
import '../../../units/data/repos/unit_repo_imp.dart';
import '../../../units/presentation/manager/unit_cubit/unit_cubit.dart';
import '../../../units/presentation/unit_view.dart';

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
          create: (context) => ExamsCubit(
            examRepo: getIt<ExamRepo>(),
            filterVisibleExams: getIt<FilterVisibleExams>(),
            filterPublishedResultsExams:
                getIt<FilterPublishedResultsExams>(),
          )..loadExams(),
          child: const ExamsView(),
        ),
        BlocProvider(
          create: (context) => LeaderboardCubit(
            leaderboardRepo: getIt<LeaderboardRepo>(),
          )..loadNow(),
          child: const LeaderboardView(),
        ),
        const SettingsView(),
      ],
    );
  }
}
