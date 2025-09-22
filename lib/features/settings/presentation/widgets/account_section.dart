import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/get_user.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("الحساب", style: TextStyles.bold20),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightBlueBackground,
            boxShadow:  [
              BoxShadow(
                color: const Color(0xff5390D9).withAlpha(100),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: UserAvatar(
              name: getUser().firstName!,
              savedColor: getUser().avatarColor!,
              imageUrl: getUser().imageUrl,
              fontSize: 24,
              radius: 34,
            ),
            title: Text(
              {getUser().firstName!, getUser().lastName!}.join(" "),
              style: TextStyles.bold18,
            ),
            subtitle: const Text("طالب", style: TextStyles.regular16),
            trailing: IconButton(
              onPressed: () {
                GoRouter.of(context).push(Routes.profileView);
              },
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AssetsData.editIcon, height: 20),
                  Text(
                    "تعديل",
                    style: TextStyles.regular13.copyWith(
                      color: const Color(0xff5390D9),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              GoRouter.of(context).push(Routes.profileView);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
