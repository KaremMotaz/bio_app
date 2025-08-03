import 'package:flutter/material.dart';
import '../../../core/theming/assets_data.dart';

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

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      indicatorColor: Colors.transparent,
      destinations: List.generate(
        icons.length,
        (index) => NavigationDestination(
          icon: Opacity(
            opacity: selectedIndex == index ? 1 : 0.5,
            child: Image.asset(icons[index], width: 35),
          ),
          label: "",
        ),
      ),
    );
  }
}
