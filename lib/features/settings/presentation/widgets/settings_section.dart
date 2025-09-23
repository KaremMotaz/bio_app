import 'package:bio_app/features/settings/presentation/widgets/app_review_list_tile.dart';
import 'package:bio_app/features/settings/presentation/widgets/report_bug_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/text_styles.dart';
import 'delete_account_list_tile.dart';
import 'logout_list_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الإعدادات", style: TextStyles.bold20),
        SizedBox(height: 20),
        AppReviewListTile(),
        SizedBox(height: 24),
        ReportBugListTile(),
        SizedBox(height: 24),
        LogoutListTile(),
        SizedBox(height: 24),
        DeleteAccountListTile(),
      ],
    );
  }
}
