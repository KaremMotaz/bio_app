import 'package:bio_app/features/leaderboard/presentation/manager/leaderboard_cubit/leaderboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/leaderboard_tab.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['حاليا', 'اسبوعيا', 'شهريا'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    // load اول تاب افتراضياً
    context.read<LeaderboardCubit>().loadNow();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          context.read<LeaderboardCubit>().loadNow();
        } else if (_tabController.index == 1) {
          context.read<LeaderboardCubit>().loadWeek();
        } else {
          context.read<LeaderboardCubit>().loadMonth();
        }
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
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final isLoading = state is LeaderboardLoadingState;
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('لوحة الصدارة'),
              bottom: TabBar(
                controller: _tabController,
                tabs: tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildTab(state: state, currentTab: tabs[0]),
                _buildTab(state: state, currentTab: tabs[1]),
                _buildTab(state: state, currentTab: tabs[2]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab({
    required LeaderboardState state,
    required String currentTab,
  }) {
    if (state is LeaderboardLoadedState) {
      return LeaderboardTab(
        leaderboardList: state.users,
        currentTab: currentTab,
      );
    } else if (state is LeaderboardErrorState) {
      return Center(child: Text(state.message));
    }
    return const SizedBox.shrink();
  }
}
