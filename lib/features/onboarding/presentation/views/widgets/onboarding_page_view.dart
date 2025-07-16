import 'package:bio_app/features/onboarding/presentation/views/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(children: [PageViewItem(), PageViewItem()]),
    );
  }
}
