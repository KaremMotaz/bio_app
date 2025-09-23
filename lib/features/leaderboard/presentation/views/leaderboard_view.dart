import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../auth/domain/user_entity.dart';
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

  final Map<LeaderboardType, List<UserEntity>> _cachedData = {};

  LeaderboardType typeFromIndex(int index) {
    switch (index) {
      case 0:
        return LeaderboardType.weekly;
      case 1:
        return LeaderboardType.daily;
      case 2:
        return LeaderboardType.monthly;
      default:
        return LeaderboardType.daily;
    }
  }

  int indexFromType(LeaderboardType type) {
    switch (type) {
      case LeaderboardType.weekly:
        return 0;
      case LeaderboardType.daily:
        return 1;
      case LeaderboardType.monthly:
        return 2;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 1,
    );

    _loadCurrentTab();

    _tabController.addListener(() {
      if (_tabController.index ==
          _tabController.animation?.value.round()) {
        setState(() {});
        _loadCurrentTab();
      }
    });
  }

  void _loadCurrentTab() {
    context.read<LeaderboardCubit>().load(
      type: typeFromIndex(_tabController.index),
    );
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
        if (state is LeaderboardLoadedState) {
          _cachedData[state.type] = state.users;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("الترتيب"),
            bottom: CustomTabBar(
              tabController: _tabController,
              tabs: tabs,
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: IndexedStack(
              index: _tabController.index,
              children: List.generate(tabs.length, (i) {
                final type = typeFromIndex(i);
                final data = _cachedData[type];

                if (state is LeaderboardErrorState &&
                    typeFromIndex(_tabController.index) == type) {
                  return Center(child: Text(state.message));
                }

                if (data != null) {
                  return LeaderboardTab(
                    leaderboardList: data,
                    currentTab: tabs[i].label,
                  );
                }

                return const CustomCircularProgressIndicator(
                  color: AppColors.mainBlue,
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class CustomTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required TabController tabController,
    required this.tabs,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<LeaderboardType> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicator: BoxDecoration(
        color: const Color(0xff48CAE4),
        borderRadius: BorderRadius.circular(20),
      ),
      // indicatorColor: AppColors.white,
      unselectedLabelColor: AppColors.black,
      labelColor: AppColors.white,
      overlayColor: const WidgetStatePropertyAll(
        AppColors.transparent,
      ),
      dividerHeight: 0,
      tabs: tabs
          .map(
            (t) => Container(
              padding: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(t.label, style: TextStyles.medium14),
            ),
          )
          .toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
