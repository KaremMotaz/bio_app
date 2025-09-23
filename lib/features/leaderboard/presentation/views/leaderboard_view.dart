import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../../domain/leaderboard_type.dart';
import '../manager/leaderboard_cubit/leaderboard_cubit.dart';
import '../widgets/leaderboard_tab.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = LeaderboardType.values;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: LeaderboardType.daily.index,
    );

    context.read<LeaderboardCubit>().load(
      type: LeaderboardTypeX.fromIndex(_tabController.index),
    );

    _tabController.addListener(() {
      if (_tabController.index ==
          _tabController.animation?.value.round()) {
        context.read<LeaderboardCubit>().load(
          type: LeaderboardTypeX.fromIndex(_tabController.index),
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الترتيب"),
        bottom: CustomTabBar(
          tabController: _tabController,
          tabs: tabs,
        ),
      ),
      body: BlocBuilder<LeaderboardCubit, LeaderboardState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: tabs.map((type) {
              if (state is LeaderboardErrorState &&
                  state.type == type) {
                return Center(child: Text(state.message));
              }

              if (state is LeaderboardLoadedState &&
                  state.type == type) {
                return LeaderboardTab(
                  leaderboardList: state.users,
                  currentTab: type.label,
                );
              }

              return const CustomCircularProgressIndicator(
                color: AppColors.mainBlue,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
