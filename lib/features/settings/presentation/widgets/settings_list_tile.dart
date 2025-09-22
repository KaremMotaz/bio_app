import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    this.subTitle,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isTrailingIcon,
  });
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Widget? subTitle;
  final bool? isTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.gray.withAlpha(80),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.grey300,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.semiBold15.copyWith(
                    color: AppColors.black,
                  ),
                ),
                if (subTitle != null)
                  Column(
                    children: [const SizedBox(height: 4), subTitle!],
                  ),
              ],
            ),
            const Spacer(),
            if (isTrailingIcon != null)
              SvgPicture.asset(
                AssetsData.chevronRightIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
