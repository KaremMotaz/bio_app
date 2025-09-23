import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_text_button.dart';

class ExamFinishedView extends StatelessWidget {
  const ExamFinishedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: AppColors.green.withAlpha(10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AppColors.green,
                      size: 70,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "تم إنهاء الامتحان",
                    style: TextStyles.bold22,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "تم إرسال إجاباتك للمراجعة بنجاح.\nسيتم إعلامك بالنتيجة قريبًا.",
                    textAlign: TextAlign.center,
                    style: TextStyles.medium16,
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: AppTextButton(
                      buttonText: "العودة للرئيسية",
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
