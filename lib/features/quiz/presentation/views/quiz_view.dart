import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import 'quiz_result_view.dart';
import 'widgets/quiz_view_body.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<QuizCubit, QuizState>(
          listener: (context, state) {
            if (state is QuizExitToHomeState) {
              GoRouter.of(context).pushReplacement(Routes.mainView);
            }
          },
          builder: (context, state) {
            if (state is QuizLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizLoadedState) {
              return QuizViewBody(state: state);
            } else if (state is QuizFinishedState) {
              return QuizResultView(finishedState: state);
            } else if (state is QuizErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
