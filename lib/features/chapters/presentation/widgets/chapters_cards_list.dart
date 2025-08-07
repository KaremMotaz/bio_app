import '../../domain/chapter_entity.dart';
import 'custom_chapter_card.dart';
import 'package:flutter/material.dart';

class ChaptersCardsList extends StatelessWidget {
  const ChaptersCardsList({super.key, required this.chapters});
  final List<ChapterEntity> chapters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(chapters.length, (index) {
        final ChapterEntity chapter = chapters[index];
        return Padding(
          padding: const EdgeInsets.only(top: 70),
          child: CustomChapterCard(
            chapter: chapters[index],
            chapterSelectedIndex: chapter.id,
          ),
        );
      }),
    );
  }
}
