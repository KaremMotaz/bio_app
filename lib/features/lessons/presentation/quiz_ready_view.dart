import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/lessons/domain/quiz_entity.dart';
import '../../../core/widgets/custom_app_bar_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';

class QuizReadyView extends StatelessWidget {
  const QuizReadyView({super.key, required this.quiz});
  final QuizEntity quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(AssetsData.quizReady),
                Text(
                  "اهلاً يا صديقى... ",
                  style: TextStyles.bold22.copyWith(
                    color: AppColors.mainBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "هل انت جاهز لبدأ الكويز؟",
                  style: TextStyles.bold22.copyWith(
                    color: AppColors.mainBlue,
                  ),
                ),
                const SizedBox(height: 40),
                AppTextButton(
                  buttonText: "هيا بنا",
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(
                      Routes.quizView,
                      extra: quiz.id,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
