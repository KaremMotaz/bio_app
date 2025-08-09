import '../manager/quiz_cubit/quiz_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../domain/lesson_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomLessonCard extends StatefulWidget {
  const CustomLessonCard({
    super.key,
    required this.lesson,
    required this.index,
  });
  final LessonEntity lesson;
  final int index;

  @override
  State<CustomLessonCard> createState() => _CustomLessonCardState();
}

class _CustomLessonCardState extends State<CustomLessonCard> {
  bool isExpanded = false;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'الدرس ${getDisplayNumber(widget.index)} : ${widget.lesson.title}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const CircleAvatar(
              backgroundColor: AppColors.mainBlue,
              child: Icon(Icons.play_lesson, color: Colors.white),
            ),
            trailing: isExpanded
                ? const Icon(Icons.expand_less, size: 30)
                : const Icon(Icons.expand_more, size: 30),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });

              if (isExpanded) {
                context.read<QuizCubit>().getQuizzes(
                  lessonId: widget.lesson.id,
                );
              }
            },
          ),

          // Expanded Section
          if (isExpanded)
            BlocBuilder<QuizCubit, QuizState>(
              builder: (context, state) {
                if (state is QuizLoadingState) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainBlue,
                      ),
                    ),
                  );
                } else if (state is QuizLoadedState) {
                  if (state.quizzes.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          "لا يوجد كويزات حاليا",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.quizzes.length,
                    itemBuilder: (context, index) {
                      final bool isSelected = selectedIndex == index;
                      return Container(
                        color: isSelected
                            ? Colors.grey[100]
                            : Colors.white,
                        child: ListTile(
                          title: Text(
                            "${index + 1}- ${state.quizzes[index].title}",
                          ),
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              GoRouter.of(context).push(
                                Routes.quizReadyView,
                                extra: state.quizzes[index].quizId,
                              );
                            });
                          },
                        ),
                      );
                    },
                  );
                } else if (state is QuizErrorState) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text("حدث خطأ أثناء تحميل الكويزات"),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
        ],
      ),
    );
  }
}
