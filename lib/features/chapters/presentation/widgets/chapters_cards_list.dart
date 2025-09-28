import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/chapter_entity.dart';
import 'custom_chapter_card.dart';

class ChaptersCardsList extends StatelessWidget {
  const ChaptersCardsList({
    super.key,
    required this.chapters,
    required this.unitId,
    this.isLoading = false,
  });
  final List<ChapterEntity> chapters;
  final String unitId;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: List.generate(chapters.length, (index) {
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(top: 40)
                : const EdgeInsets.only(top: 70),
            child: CustomChapterCard(
              chapter: chapters[index],
              unitId: unitId,
            ),
          );
        }),
      ),
    );
  }
}
