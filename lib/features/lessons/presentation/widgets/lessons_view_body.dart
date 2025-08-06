import '../../domain/lesson_entity.dart';
import 'lessons_cards_list.dart';
import 'package:flutter/material.dart';

class LessonsViewBody extends StatelessWidget {
  const LessonsViewBody({super.key, required this.lessons});
  final List<LessonEntity> lessons;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Lessons"),
            LessonsCardsList(lessons: lessons),
          ],
        ),
      ),
    );
  }
}
