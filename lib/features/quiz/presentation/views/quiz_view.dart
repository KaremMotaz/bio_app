import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import '../widgets/quiz_view_body.dart';
import 'quiz_result_view.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<QuizCubit, QuizState>(
          listenWhen: (prev, curr) => curr is QuizExitToHomeState,
          listener: (context, state) {
            if (state is QuizExitToHomeState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(Routes.mainView);
              });
            }
          },
          child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) => switch (state) {
              QuizLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              QuizLoadedState() => QuizViewBody(state: state),
              QuizFinishedState() => QuizResultView(
                finishedState: state,
              ),
              QuizErrorState(:final message) => Center(
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
