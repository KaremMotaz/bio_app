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
      AssetsData.settingsIcon,
    ];
    final List<String> labels = [
      "الرئيسية",
      "الإمتحانات",
      "ترتيبك",
      "الإعدادات",
    ];

    return BottomAppBar(
      color: Colors.white,
      height: 80,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEDF5F7),
          borderRadius: BorderRadius.circular(32),
        ),
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
    );
  }
}
