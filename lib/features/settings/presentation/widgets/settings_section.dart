import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/settings/presentation/widgets/delete_account_list_tile.dart';
import 'package:bio_app/features/settings/presentation/widgets/logout_list_tile.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الإعدادات", style: TextStyles.bold20),
        SizedBox(height: 20),
        LogoutListTile(),
        SizedBox(height: 8),
        DeleteAccountListTile(),
      ],
    );
  }
}



