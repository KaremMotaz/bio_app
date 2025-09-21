import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import '../manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/result_data_frame.dart';

class QuizResultView extends StatelessWidget {
  const QuizResultView({super.key, required this.finishedState});
  final QuizQuestionsFinishedState finishedState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            "لقد\n اكملت \nالدرس!",
            textAlign: TextAlign.center,
            style: TextStyles.extraBold30.copyWith(
              color: AppColors.amber,
            ),
          ),
          Image.asset(AssetsData.finishLesson, height: 280),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ResultDataFrame(
                color: AppColors.amberAccent,
                data: '${finishedState.result.finalScore}',
                icon: AssetsData.expIcon,
                title: 'إجمالي النقاط',
              ),
              ResultDataFrame(
                color: AppColors.buttonBlue,
                data: finishedState.result.formattedDuration,
                icon: AssetsData.timerIcon,
                title: 'الوقت',
              ),
              ResultDataFrame(
                color: AppColors.mainGreen,
                data: '${finishedState.result.accuracy}%',
                icon: AssetsData.targetIcon,
                title: 'الدقة',
              ),
            ],
          ),
          CustomButton(
            text: "المتابعة",
            color: AppColors.buttonBlue,
            shadowColor: AppColors.darkerBlue,
            isEnabled: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
