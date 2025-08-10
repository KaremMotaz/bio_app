import 'package:flutter/material.dart';
import '../../../exam_questions/domain/entities/exam_question_entity.dart';
import '../../data/services/exam_grading_service.dart';
import 'exam_result_details_question_card.dart';

class ExamResultDetailsPageView extends StatelessWidget {
  const ExamResultDetailsPageView({
    super.key,
    required this.examQuestions,
    required this.pageController,
    required this.onPageChanged,
    required this.answers,
  });
  final List<ExamQuestionEntity> examQuestions;
  final PageController pageController;
  final Function(int) onPageChanged;
  final Map<String, int> answers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: examQuestions.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final ExamQuestionEntity question = examQuestions[index];
          return ExamResultDetailsQuestionCard(
            question: question,
            isCorrect: ExamGradingService.isCorrectAnswer(
              question,
              answers,
            ),
            answers: answers,
          );
        },
      ),
    );
  }
}
