import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

class AppEvaluationListTile extends StatelessWidget {
  const AppEvaluationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "اكتب تقييم",
      icon: AssetsData.appEvaluationIcon,
      onTap: () {},
      isTrailingIcon: true,
    );
  }
}
