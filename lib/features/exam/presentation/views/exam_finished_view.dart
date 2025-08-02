import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_text_button.dart';

class ExamFinishedView extends StatelessWidget {
  const ExamFinishedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("تم ارسال الأسئلة للمراجعة"),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: AppTextButton(
            buttonText: "حسنا",
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
