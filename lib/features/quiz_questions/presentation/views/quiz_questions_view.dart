import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import '../widgets/quiz_view_body.dart';
import 'quiz_result_view.dart';

class QuizQuestionsView extends StatelessWidget {
  const QuizQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<QuizQuestionsCubit, QuizQuestionsState>(
          listenWhen: (prev, curr) =>
              curr is QuizQuestionsExitToHomeState,
          listener: (context, state) {
            if (state is QuizQuestionsExitToHomeState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                GoRouter.of(context).pop();
              });
            }
          },
          child: BlocBuilder<QuizQuestionsCubit, QuizQuestionsState>(
            builder: (context, state) => switch (state) {
              QuizQuestionsLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              QuizQuestionsLoadedState() => QuizViewBody(
                state: state,
              ),
              QuizQuestionsFinishedState() => QuizResultView(
                finishedState: state,
              ),
              QuizQuestionsErrorState(:final message) => Center(
                child: Text(message),
              ),
              _ => const SizedBox.shrink(),
            },
          ),
        ),
      ),
    );
  }
}
