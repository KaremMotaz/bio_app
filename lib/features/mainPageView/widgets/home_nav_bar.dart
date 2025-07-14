import 'package:flutter/material.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/mainPageView/widgets/nav_icon.dart';

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
    final icons = [
      AssetsData.heartIcon,
      AssetsData.heartIcon,
      AssetsData.heartIcon,
      AssetsData.heartIcon,
    ];
    final labels = ['Home', 'Exams', 'Leaderboard', 'Sittings'];

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        return TextStyle(
          color: states.contains(WidgetState.selected)
              ? Colors.black
              : AppColors.darkBlue,
        );
      }),
      indicatorColor: Colors.transparent,
      destinations: List.generate(
        icons.length,
        (index) => NavigationDestination(
          icon: NavIcon(
            assetPath: icons[index],
            isSelected: selectedIndex == index,
          ),
          label: labels[index],
        ),
      ),
    );
  }
}
