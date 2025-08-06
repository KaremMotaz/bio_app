import 'package:bio_app/core/helpers/constants.dart';
import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/chapters/domain/chapter_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomChapterCard extends StatelessWidget {
  const CustomChapterCard({
    super.key,
    required this.chapter,
    required this.chapterSelectedIndex,
    required this.unitId,
  });
  final ChapterEntity chapter;
  final int chapterSelectedIndex;
  final int unitId;

  @override
  Widget build(BuildContext context) {
    final List<int> colorPair =
        AppColors.predefinedColorPairsForChapters[chapter.colorIndex];
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          Routes.lessonsView,
          extra: {'chapterIndex': chapter.id, 'unitIndex': unitId},
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(colorPair[0]), Color(colorPair[1])],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(70),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الفصل ${getDisplayNumber(chapterSelectedIndex)}",
                  style: TextStyles.bold14.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chapter.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bold20.copyWith(
                    color: AppColors.mainpurple,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: -45,
            left: 30,
            child: Image.network(
              chapter.image,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
