import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../data/repos/quiz_repo_imp.dart';
import '../../domain/lesson_entity.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import 'custom_lesson_card.dart';

class LessonsCardsList extends StatelessWidget {
  const LessonsCardsList({super.key, required this.lessons});
  final List<LessonEntity> lessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(lessons.length, (index) {
        return Padding(
          padding: index == 0
              ? const EdgeInsets.only(top: 0)
              : const EdgeInsets.only(top: 20),
          child: BlocProvider(
            create: (context) =>
                QuizCubit(quizRepoImp: getIt<QuizRepoImp>()),
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
