import 'package:flutter/material.dart';

import '../../domain/lesson_entity.dart';
import 'lessons_cards_list.dart';

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
            LessonsCardsList(lessons: lessons),
          ],
        ),
      ),
    );
  }
}
