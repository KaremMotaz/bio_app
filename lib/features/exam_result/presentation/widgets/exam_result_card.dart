import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam_result/presentation/manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/exam_result_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ExamResultCard extends StatelessWidget {
  const ExamResultCard({
    super.key,
    required this.isPassed,
    required this.state,
  });

  final bool isPassed;
  final ExamResultLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPassed ? LucideIcons.award : LucideIcons.xCircle,
              size: 80,
              color: isPassed ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              isPassed ? "مبروك!" : "للأسف!",
              style: TextStyles.extraBold24.copyWith(
                color: isPassed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isPassed
                  ? "لقد نجحت في الإمتحان 🎉"
                  : "لقد رسبت في الإمتحان 😔",
              style: TextStyles.medium16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.grey, thickness: 1),
            const SizedBox(height: 16),
            ExamResultListTile(
              title: "النسبة المئوية",
              value: "${state.percentage.toStringAsFixed(2)}%",
              icon: LucideIcons.percent,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            ExamResultListTile(
              title: "درجتك",
              value: "${state.studentScore} / ${state.maxScore}",
              icon: LucideIcons.checkCircle,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
