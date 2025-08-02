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
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
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
        OnboardingPageView(pageController: _pageController, pages: pages),
        DotsIndicator(
          dotsCount: 3,
          position: currentPageIndex.toDouble(),
          decorator: const DotsDecorator(
            color: AppColors.gray,
            activeColor: AppColors.mainBlue,
          ),
        ),
        const SizedBox(height: 20),
        if (currentPageIndex == 0 || currentPageIndex == 1) ...[
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.mainBlue,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                goToNextPage();
              },
              icon: const Icon(
                Icons.arrow_right_alt_sharp,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
        if (currentPageIndex == 2) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextButton(
              buttonText: "ابدء الآن",
              textStyle: TextStyles.bold17.copyWith(color: Colors.white),
              onPressed: () {
                CacheHelper.set(key: kHasSeenOnboarding, value: true);
                GoRouter.of(context).pushReplacement(Routes.signInView);
              },
            ),
          ),
        ],

        const SizedBox(height: 40),
      ],
    );
  }
}
