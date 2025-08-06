import 'package:bio_app/features/chapters/domain/chapter_entity.dart';
import 'package:bio_app/features/chapters/presentation/widgets/chapters_cards_list.dart';
import 'package:flutter/material.dart';

class ChapterViewBody extends StatelessWidget {
  const ChapterViewBody({
    super.key,
    required this.chapters,
    required this.unitId,
  });
  final List<ChapterEntity> chapters;
  final int unitId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chapters"),
            ChaptersCardsList(chapters: chapters, unitId: unitId),
          ],
        ),
      ),
    );
  }
}
