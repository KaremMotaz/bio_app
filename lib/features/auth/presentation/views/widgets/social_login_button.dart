import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.title,
    required this.imageLink,
    required this.onPressed,
  });
  final String title;
  final String imageLink;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.lightGray),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 12),
        ),
        fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
      ),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.semiBold15,
        ),
        leading: SvgPicture.asset(imageLink),
      ),
    );
  }
}
