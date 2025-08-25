import 'account_section.dart';
import 'settings_section.dart';
import 'package:flutter/material.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            AccountSection(),
            SizedBox(height: 30),
            SettingsSection(),
          ],
        ),
      ),
    );
  }
}
