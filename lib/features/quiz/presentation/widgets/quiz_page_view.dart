import 'package:flutter/material.dart';

import '../manager/quiz_cubit/quiz_cubit.dart';
import 'quiz_question_card.dart';

class QuizPageView extends StatefulWidget {
  const QuizPageView({super.key, required this.state});
  final QuizLoadedState state;

  @override
  State<QuizPageView> createState() => _QuizPageViewState();
}

class _QuizPageViewState extends State<QuizPageView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToCurrentQuestion(int newIndex) {
    _pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(covariant QuizPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldIndex = oldWidget.state.progress.currentQuestionIndex;
    final newIndex = widget.state.progress.currentQuestionIndex;

    if (newIndex != oldIndex) {
      _animateToCurrentQuestion(newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.questions.length,
        itemBuilder: (context, index) {
          return QuizQuestionCard(
            key: ValueKey(state.progress.currentQuestionIndex),
            question: state.questions[index],
            answerState: state.answerState,
          );
        },
      ),
    );
  }
}
