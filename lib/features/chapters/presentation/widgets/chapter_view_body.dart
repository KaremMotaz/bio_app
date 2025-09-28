import 'package:flutter/material.dart';

import '../../domain/chapter_entity.dart';
import 'chapters_cards_list.dart';

class ChapterViewBody extends StatelessWidget {
  const ChapterViewBody({
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChaptersCardsList(
              chapters: chapters,
              unitId: unitId,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
