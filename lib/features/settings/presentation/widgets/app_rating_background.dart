import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../../core/widgets/close_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppRatingBackground extends StatelessWidget {
  const AppRatingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(0, -26),
          child: SvgPicture.asset(AssetsData.reviewBackground),
        ),
        const CloseIcon(color: AppColors.white),
      ],
    );
  }
}
