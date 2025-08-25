import '../../../../core/theming/text_styles.dart';
import 'delete_account_list_tile.dart';
import 'logout_list_tile.dart';
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



