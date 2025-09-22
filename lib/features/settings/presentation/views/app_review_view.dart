import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';
import 'package:bio_app/features/settings/presentation/widgets/app_review_body.dart';
import 'package:flutter/material.dart';

class AppReviewView extends StatelessWidget {
  const AppReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
        title: const Text("تقييم التطبيق"),
      ),
      body: const AppReviewBody(),
    );
  }
}
