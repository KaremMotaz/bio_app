import 'package:bio_app/core/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/correct_answer_card.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/wrong_answer_card.dart';
import 'package:flutter/material.dart';

class ResultFeedbackCard extends StatelessWidget {
  const ResultFeedbackCard({
    super.key,
    required this.isCorrect,
    required this.question,
  });
  final bool isCorrect;
  final ExamQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return isCorrect
        ? CorrectAnswerCard(question: question)
        : WrongAnswerCard(question: question);
  }
}
