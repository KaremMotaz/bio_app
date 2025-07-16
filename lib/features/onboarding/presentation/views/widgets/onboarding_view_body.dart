import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingPageView(),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            color: AppColors.mainGreen,
            activeColor: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppTextButton(
            buttonText: "ابدأ الآن",
            textStyle: TextStyles.bold17.copyWith(color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
