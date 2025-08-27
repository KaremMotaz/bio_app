import 'package:bio_app/features/auth/domain/user_entity.dart';
import 'package:bio_app/features/leaderboard/domain/leaderboard_type.dart';
import '../manager/leaderboard_cubit/leaderboard_cubit.dart';
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

  // لتخزين آخر بيانات محملة لكل تاب
  final Map<LeaderboardType, List<UserEntity>> _cachedData = {};

  LeaderboardType get _currentType {
    switch (_tabController.index) {
      case 0:
        return LeaderboardType.daily;
      case 1:
        return LeaderboardType.weekly;
      case 2:
      default:
        return LeaderboardType.monthly;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    // تحميل أول تاب افتراضياً
    _loadCurrentTab();

    _tabController.addListener(() {
      if (_tabController.index ==
          _tabController.animation?.value.round()) {
        setState(() {}); // لتحديث IndexedStack
        _loadCurrentTab();
      }
    });
  }

  void _loadCurrentTab() {
    context.read<LeaderboardCubit>().load(type: _currentType);
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

        // حفظ البيانات عند التحميل الناجح
        if (state is LeaderboardLoadedState) {
          _cachedData[_currentType] = state.users;
        }

        return ModalProgressHUD(
          inAsyncCall:
              isLoading && (_cachedData[_currentType] == null),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('لوحة الصدارة'),
              bottom: TabBar(
                controller: _tabController,
                tabs: tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: IndexedStack(
                index: _tabController.index,
                children: tabs.map((tabName) {
                  final type = tabs.indexOf(tabName) == 0
                      ? LeaderboardType.daily
                      : tabs.indexOf(tabName) == 1
                      ? LeaderboardType.weekly
                      : LeaderboardType.monthly;

                  final data = _cachedData[type];

                  if (state is LeaderboardErrorState &&
                      _currentType == type) {
                    return Center(child: Text(state.message));
                  }

                  if (data != null) {
                    return LeaderboardTab(
                      leaderboardList: data,
                      currentTab: tabName,
                    );
                  }

                  // إذا لم توجد بيانات بعد
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
