import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';
import 'package:bio_app/features/settings/presentation/widgets/contact_us_list_tile.dart';
import 'package:bio_app/features/settings/presentation/widgets/privacy_tip_list_tile.dart';
import 'package:bio_app/features/settings/presentation/widgets/terms_and_conditions_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عن التطبيق"),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightBlueBackground,
              ),
              child: SvgPicture.asset(
                AssetsData.splashLogo,
                height: 55,
                width: 55,
                colorFilter: const ColorFilter.mode(
                  AppColors.mainBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // App name + version
            const Text(
              "Biotics App",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "الإصدار 1.0.0",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "تطبيق Biotics لتعلم مادة الأحياء بشكل ممتع وسهل، "
                "مع كويزات وامتحانات.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            // Links
            const PrivacyTipListTile(),
            const SizedBox(height: 20),
            const TermsAndConditionsListTile(),
            const SizedBox(height: 20),
            const ContactUsListTile(),
            const Spacer(),
            // Footer
            const Text(
              "© 2025 Biotics Inc. جميع الحقوق محفوظة",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
