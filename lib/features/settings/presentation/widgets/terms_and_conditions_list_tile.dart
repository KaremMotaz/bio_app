import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/assets_data.dart';

class TermsAndConditionsListTile extends StatelessWidget {
  const TermsAndConditionsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      bgIconcolor: AppColors.white,
      iconHeight: 25,
      title: "الشروط والأحكام",
      onTap: () {
        GoRouter.of(context).push(Routes.termsAndConditionsView);
      },
      isTrailingIcon: true,
      icon: AssetsData.lockFillIcon,
    );
  }
}
