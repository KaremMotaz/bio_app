// import 'package:bio_app/core/constants/constants.dart';
import 'package:bio_app/core/routing/routes.dart';
// import 'package:bio_app/core/services/cache_helper.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  int currentPageIndex = 0;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingPageView(pageController: pageController),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            color: currentPageIndex == 1
                ? AppColors.darkGreen
                : AppColors.mainGreen,
            activeColor: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: currentPageIndex == 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextButton(
              buttonText: "ابدأ الآن",
              textStyle: TextStyles.bold17.copyWith(color: Colors.white),
              onPressed: () {
                // CacheHelper.set(key: kHasSeenOnboarding, value: true);
                GoRouter.of(context).pushReplacement(Routes.signInView);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
