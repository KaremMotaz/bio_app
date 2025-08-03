import 'package:flutter/material.dart';

import '../../../../../core/theming/text_styles.dart';

class CustomSettingsListTile extends StatelessWidget {
  const CustomSettingsListTile({
    super.key,
    required this.iconcolor,
    required this.bgIconcolor,
    required this.title,
    required this.onTap,
    required this.trailing,
    required this.icon,
  });
  final Color iconcolor;
  final Color bgIconcolor;
  final String title;
  final VoidCallback onTap;
  final Widget trailing;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: bgIconcolor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: iconcolor),
      ),
      title: Text(title, style: TextStyles.bold18),
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
