import '../../../../core/widgets/custom_app_bar_pop_icon.dart';
import '../widgets/app_rating_consumer.dart';
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
      body: const AppRatingConsumer(),
    );
  }
}
