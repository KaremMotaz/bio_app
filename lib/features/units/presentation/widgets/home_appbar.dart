import 'package:bio_app/core/helpers/get_user.dart';
import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/user_avatar.dart';
import 'package:bio_app/features/units/presentation/widgets/notifications_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 60,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        color: AppColors.mainBlue,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(Routes.profileView);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 3),
              ),
              child: UserAvatar(
                name: getUser().firstName!,
                savedColor: getUser().avatarColor!,
                imageUrl: getUser().imageUrl,
                fontSize: 24,
                radius: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "أهلاً بك ${getUser().firstName} !",
                style: TextStyles.bold20.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "مستعد للتحدى؟!",
                style: TextStyles.regular16.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  AssetsData.sideBarIcon,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const NotificationsWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
