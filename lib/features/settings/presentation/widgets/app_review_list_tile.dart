import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppReviewListTile extends StatelessWidget {
  const AppReviewListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "اكتب تقييماً",
      icon: AssetsData.appEvaluationIcon,
      onTap: () {
        GoRouter.of(context).push(Routes.appReviewView);
      },
      isTrailingIcon: true,
    );
  }
}
