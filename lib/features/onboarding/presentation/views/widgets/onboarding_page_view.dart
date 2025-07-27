import 'package:flutter/material.dart';
import 'page_view_item.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.pageController,
    required this.pages,
  });
  final PageController pageController;
  final List<PageViewItem> pages;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(controller: pageController, children: pages),
    );
  }
}
