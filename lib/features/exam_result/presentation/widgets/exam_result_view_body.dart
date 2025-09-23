import 'exam_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';

class ExamResultViewBody extends StatelessWidget {
  const ExamResultViewBody({super.key, required this.state});
  final ExamResultLoadedState state;

  @override
  Widget build(BuildContext context) {
    final bool isPassed = state.isPassed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExamResultCard(isPassed: isPassed, state: state),
          const SizedBox(height: 50),
          AppTextButton(
            buttonText: "عرض تفاصيل النتيجة",
            onPressed: () {
              final cubit = BlocProvider.of<ExamResultCubit>(context);
              GoRouter.of(
                context,
              ).push(Routes.examResultDetailsView, extra: cubit);
            },
          ),
        ],
      ),
    );
  }
}
