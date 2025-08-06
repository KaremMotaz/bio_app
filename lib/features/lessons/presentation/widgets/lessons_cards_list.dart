import '../../domain/lesson_entity.dart';
import 'custom_lesson_card.dart';
import 'package:flutter/material.dart';

class LessonsCardsList extends StatelessWidget {
  const LessonsCardsList({super.key, required this.lessons});
  final List<LessonEntity> lessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(lessons.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CustomLessonCard(
            lesson: lessons[index],
            index: index,
          ),
        );
      }),
    );
  }
}
