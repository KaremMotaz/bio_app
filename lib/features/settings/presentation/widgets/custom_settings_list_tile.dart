import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';

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
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        border: Border.all(color: iconcolor.withAlpha(40), width: 1),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(iconcolor, BlendMode.srcIn),
        ),
        title: Text(
          title,
          style: TextStyles.semiBold16.copyWith(color: iconcolor),
        ),
        trailing: trailing,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
