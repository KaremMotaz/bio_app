import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/features/lessons/domain/lesson_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomLessonCard extends StatefulWidget {
  const CustomLessonCard({super.key, required this.lesson});
  final LessonEntity lesson;

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
              widget.lesson.title,
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
              itemCount: widget.lesson.topics.length,
              itemBuilder: (context, index) {
                final item = widget.lesson.topics[index];
                final isSelected = selectedIndex == index;
                return Container(
                  color: isSelected ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        GoRouter.of(context).push(Routes.quizReadyView);
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
