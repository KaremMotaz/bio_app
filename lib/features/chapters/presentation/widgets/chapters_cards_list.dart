import '../../domain/chapter_entity.dart';
import 'custom_chapter_card.dart';
import 'package:flutter/material.dart';

class ChaptersCardsList extends StatelessWidget {
  const ChaptersCardsList({
    super.key,
    required this.chapters,
    required this.unitId,
  });
  final List<ChapterEntity> chapters;
  final String unitId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(chapters.length, (index) {
        return Padding(
          padding: index == 0
              ? const EdgeInsets.only(top: 45)
              : const EdgeInsets.only(top: 70),
          child: CustomChapterCard(
            chapter: chapters[index],
            unitId: unitId,
          ),
        );
      }),
    );
  }
}
