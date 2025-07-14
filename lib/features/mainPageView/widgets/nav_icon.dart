import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bio_app/core/theming/app_colors.dart';

class NavIcon extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final double height;

  const NavIcon({
    super.key,
    required this.assetPath,
    required this.isSelected,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      height: height,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.black : AppColors.darkBlue,
        BlendMode.srcIn,
      ),
    );
  }
}
