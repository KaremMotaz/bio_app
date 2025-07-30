import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/services/cache_helper.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.isVisible,
    required this.title,
    required this.imageUrl,
  });
  final bool isVisible;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Visibility(
                visible: isVisible,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: TextButton(
                  onPressed: () {
                    CacheHelper.set(key: kHasSeenOnboarding, value: true);
                    GoRouter.of(context).pushReplacement(Routes.signInView);
                  },
                  child: Text(
                    "تخطٍ",
                    style: TextStyles.bold14.copyWith(color: AppColors.gray),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Image.asset(imageUrl),
          ),
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.bold20.copyWith(color: AppColors.mainBlue),
            ),
          ),
        ],
      ),
    );
  }
}
