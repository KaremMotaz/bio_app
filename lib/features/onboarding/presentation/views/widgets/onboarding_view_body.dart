import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/services/cache_helper.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/assets_data.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text_button.dart';
import 'onboarding_page_view.dart';
import 'page_view_item.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() =>
      _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  int currentPageIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentPageIndex = _pageController.page!.round();
      });
    });
  }

  void goToNextPage() {
    if (currentPageIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<PageViewItem> pages = [
    const PageViewItem(
      isVisible: true,
      title: 'اختبارات دورية على كل فصل',
      imageUrl: AssetsData.onboarding1,
    ),
    const PageViewItem(
      isVisible: true,
      title: 'اطلاع مستمر على نتائجك ومستواك مقارنة بباقى زملائك',
      imageUrl: AssetsData.onboarding2,
    ),
    const PageViewItem(
      isVisible: false,
      title: 'مكافأت قيمة وتشجيع مستمر',
      imageUrl: AssetsData.onboarding3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingPageView(
          pageController: _pageController,
          pages: pages,
        ),
        DotsIndicator(
          dotsCount: 3,
          position: currentPageIndex.toDouble(),
          decorator: const DotsDecorator(
            color: AppColors.gray,
            activeColor: AppColors.mainBlue,
            size: Size(14, 14),
            activeSize: Size(14, 14),
          ),
        ),
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75),
          child: AppTextButton(
            textStyle: TextStyles.bold17.copyWith(
              color: Colors.white,
            ),
            onPressed: () {
              if (currentPageIndex < pages.length - 1) {
                goToNextPage();
                return;
              }
              CacheHelper.set(key: kHasSeenOnboarding, value: true);
              GoRouter.of(context).pushReplacement(Routes.signInView);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentPageIndex < pages.length - 1
                      ? "التالي"
                      : "ابدء الآن",
                  style: TextStyles.medium20.copyWith(
                    color: Colors.white,
                  ),
                ),
                if (currentPageIndex < pages.length - 1) ...[
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 25,
                    color: Colors.white,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
