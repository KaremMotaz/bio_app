import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportBugListTile extends StatelessWidget {
  const ReportBugListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "إبلاغ عن خطأ",
      icon: AssetsData.bugIcon,
      onTap: () {
        GoRouter.of(context).push(Routes.reportBugView);
      },
      isTrailingIcon: true,
    );
  }
}
