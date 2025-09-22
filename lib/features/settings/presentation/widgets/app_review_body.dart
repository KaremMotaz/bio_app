import 'package:bio_app/features/settings/presentation/widgets/app_review_form.dart';
import 'package:flutter/material.dart';

class AppReviewBody extends StatelessWidget {
  const AppReviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [AppReviewForm()]),
      ),
    );
  }
}
