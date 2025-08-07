import '../../domain/chapter_entity.dart';
import 'chapters_cards_list.dart';
import 'package:flutter/material.dart';

class ChapterViewBody extends StatelessWidget {
  const ChapterViewBody({
    super.key,
    required this.chapters,
  });
  final List<ChapterEntity> chapters;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chapters"),
            ChaptersCardsList(chapters: chapters),
          ],
        ),
      ),
    );
  }
}
