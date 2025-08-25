import '../../../core/widgets/custom_app_bar_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';

class QuizReadyView extends StatelessWidget {
  const QuizReadyView({super.key, required this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تحدي",
          style: TextStyles.bold18.copyWith(
            color: AppColors.mainBlue,
          ),
        ),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                buttonText: "اضغط لبدء التحدى",
                onPressed: () {
                  GoRouter.of(
                    context,
                  ).pushReplacement(Routes.quizView, extra: quizId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
