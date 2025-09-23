import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/leaderboard/domain/leaderboard_type.dart';
import 'package:flutter/material.dart';

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
