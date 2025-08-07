import 'package:bio_app/core/services/get_it_service.dart';
import 'package:bio_app/features/lessons/data/repos/quiz_repo_imp.dart';
import 'package:bio_app/features/lessons/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocProvider(
            create: (context) =>
                QuizCubit(quizRepoImp: getIt<QuizRepoImp>())
                  ..getQuizzes(lessonId: lessons[index].id),
            child: CustomLessonCard(
              lesson: lessons[index],
              index: index,
            ),
          ),
        );
      }),
    );
  }
}
