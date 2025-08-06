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
  List<String> quizzes = ["الاختبار 1", "الاختبار 2", "الاختبار 3"];

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
            },
          ),
          if (isExpanded)
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final String item = quizzes[index];
                final bool isSelected = selectedIndex == index;
                return Container(
                  color: isSelected ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        GoRouter.of(
                          context,
                        ).push(Routes.quizReadyView);
                      });
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
