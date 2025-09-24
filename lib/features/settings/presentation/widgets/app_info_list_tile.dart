import '../../../../core/routing/routes.dart';
import '../../../../core/theming/assets_data.dart';
import 'settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppInfoListTile extends StatelessWidget {
  const AppInfoListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "عن التطبيق",
      icon: AssetsData.infoIcon,
      onTap: () {
        GoRouter.of(context).push(Routes.appInfoView);
      },
      isTrailingIcon: true,
    );
  }
}
