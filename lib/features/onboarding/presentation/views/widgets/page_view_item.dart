// import 'package:bio_app/core/constants/constants.dart';
import 'package:bio_app/core/routing/routes.dart';
// import 'package:bio_app/core/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.isVisible});
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Visibility(
            visible: isVisible,
            child: TextButton(
              onPressed: () {
                // CacheHelper.set(key: kHasSeenOnboarding, value: true);
                GoRouter.of(context).pushReplacement(Routes.signInView);
              },
              child: Text("تخط"),
            ),
          ),
          Text('Onboarding Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
