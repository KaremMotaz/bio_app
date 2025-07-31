import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/features/exam_result/presentation/manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExamResultViewBody extends StatelessWidget {
  const ExamResultViewBody({super.key, required this.state});
  final ExamResultLoadedState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("النتيجة"),
        const SizedBox(height: 40),
        if (state.isPassed) ...[
          const Text("مبروك!"),
        ] else ...[
          const Text("للاسف!"),
          const Text("لقد فشلت في الاختبار"),
        ],
        Text('${state.percentage.toStringAsFixed(2)}%'),
        const SizedBox(height: 20),
        Text("درجتك هي ${state.studentScore} من ${state.maxScore}"),
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: AppTextButton(
            buttonText: "عرض تفاصيل النتيجة",
            onPressed: () {
              final cubit = BlocProvider.of<ExamResultCubit>(context);
              GoRouter.of(
                context,
              ).push(Routes.examResultDetailsView, extra: cubit);
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: AppTextButton(
            buttonText: "الذهاب للصفحة الرئيسية",
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
