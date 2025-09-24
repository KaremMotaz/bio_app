import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theming/assets_data.dart';

class ContactUsListTile extends StatelessWidget {
  const ContactUsListTile({super.key});
  Future<void> _launchEmail({required BuildContext context}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@biotics.com',
      query: 'subject=دعم التطبيق&body=مرحبا، أود الاستفسار عن...',
    );

    if (!await launchUrl(
      emailUri,
      mode: LaunchMode.externalApplication,
    )) {
      String message = "لا يمكن فتح تطبيق البريد على هذا الجهاز";
      if (context.mounted) {
        errorSnackBar(context: context, message: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      bgIconcolor: AppColors.white,
      iconHeight: 25,
      title: "تواصل معنا",
      onTap: () {
        _launchEmail(context: context);
      },
      subTitle: const Text(
        "support@biotics.com",
        style: TextStyles.regular16,
      ),
      icon: AssetsData.emailFillIcon,
    );
  }
}
