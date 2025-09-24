import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';
import 'package:bio_app/features/settings/data/models/terms_item_model.dart';
import 'package:bio_app/features/settings/presentation/widgets/terms_and_conditions_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TermsItemModel> termsItems = TermsItemModel.termsItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("الشروط والأحكام"),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "مرحباً بك في تطبيقنا 👋",
                style: TextStyles.bold18,
              ),
              const SizedBox(height: 12),
              const Text(
                "يرجى قراءة الشروط والأحكام بعناية قبل استخدام التطبيق:",
                style: TextStyles.medium14,
              ),
              const SizedBox(height: 20),
              Column(
                children: termsItems
                    .map(
                      (item) => TermsAndConditionsCard(
                        title: item.title,
                        content: item.content,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: AppTextButton(
                  buttonText: "موافق",
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
