import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({
    super.key,
    required this.selectedIndex,
    required this.icons,
    required this.labels,
    required this.index,
  });

  final int selectedIndex;
  final int index;
  final List<String> icons;
  final List<String> labels;
  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetsData.arrowBottomBarIcon,
          height: 6,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.mainBlue : Colors.transparent,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 15),
        SvgPicture.asset(
          icons[index],
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.mainBlue : Colors.black,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isSelected
              ? Text(
                  labels[index],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.mainBlue
                        : Colors.black,
                  ),
                )
              : const Text(
                  "",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
