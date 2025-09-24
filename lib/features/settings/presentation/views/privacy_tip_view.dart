import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/settings/data/models/privacy_item_model.dart';
import 'package:bio_app/features/settings/presentation/widgets/privacy_card.dart';
import 'package:flutter/material.dart';
import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';

class PrivacyTipView extends StatelessWidget {
  const PrivacyTipView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PrivacyItemModel> privacyItems =
        PrivacyItemModel.privacyItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("سياسة الخصوصية"),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.privacy_tip_rounded,
                color: AppColors.grey,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text("خصوصيتك تهمنا", style: TextStyles.bold20),
              const SizedBox(height: 10),
              const Text(
                "نحن ملتزمون بحماية بياناتك الشخصية وضمان استخدام آمن لتطبيقنا. "
                "من خلال هذه السياسة، نوضح كيف يتم جمع بياناتك واستخدامها وحمايتها.",
                style: TextStyles.regular16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Column(
                children: privacyItems
                    .map(
                      (item) => PrivacyCard(
                        title: item.title,
                        description: item.description,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
