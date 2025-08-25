import 'package:flutter/material.dart';

import '../../domain/lesson_entity.dart';
import 'lessons_cards_list.dart';

class LessonsViewBody extends StatelessWidget {
  const LessonsViewBody({
    super.key,
    required this.lessons,
    required this.chapterImage,
  });
  final List<LessonEntity> lessons;
  final String chapterImage;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Transform.translate(
              offset: Offset(0, screenHeight/4),
              child: Image.network(chapterImage, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [LessonsCardsList(lessons: lessons)],
            ),
          ),
        ],
      ),
    );
  }
}
