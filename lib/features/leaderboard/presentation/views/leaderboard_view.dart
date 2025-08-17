import '../../../../core/theming/text_styles.dart';
import '../../data/mock_leaderboard.dart';
import '../widgets/custom_tabs.dart';
import '../widgets/leaderboard_tab.dart';
import 'package:flutter/material.dart';

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
    _tabController.addListener(() {
      setState(() {});
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
        title: Text(
          'لوحة الصدارة',
          style: TextStyles.bold18.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        bottom: CustomTabs(tabs: tabs, tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LeaderboardTab(nowLeaderboardList: nowLeaderboardList),
          LeaderboardTab(nowLeaderboardList: nowLeaderboardList),
          LeaderboardTab(nowLeaderboardList: nowLeaderboardList),
        ],
      ),
    );
  }
}
