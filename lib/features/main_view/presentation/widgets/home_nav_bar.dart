import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/features/main_view/presentation/widgets/nav_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/assets_data.dart';

class HomeNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const HomeNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      AssetsData.homeIcon,
      AssetsData.examIcon,
      AssetsData.leaderboardIcon,
      AssetsData.personIcon,
    ];
    final List<String> labels = [
      "الرئيسية",
      "الإمتحانات",
      "ترتيبك",
      "الإعدادات",
    ];

    return BottomAppBar(
      color: AppColors.white,
      height: 96,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEDF5F7),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(80),
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              icons.length,
              (index) => GestureDetector(
                onTap: () => onTap(index),
                child: NavWidget(
                  selectedIndex: selectedIndex,
                  icons: icons,
                  labels: labels,
                  index: index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
