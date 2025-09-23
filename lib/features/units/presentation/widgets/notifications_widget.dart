import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(Routes.notificationsView);
          },
          child: SvgPicture.asset(
            AssetsData.notificationsIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 13,
            width: 13,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkRed,
            ),
            child: Center(
              child: Text(
                "2",
                style: TextStyles.bold9.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
