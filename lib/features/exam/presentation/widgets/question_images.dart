import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/entities/base_question_entity.dart';

class QuestionImages<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const QuestionImages({super.key, required this.question});
  final T question;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (question.images != null) ...[
          const SizedBox(height: 20),
          ...List.generate(question.images!.length, (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: question.images![index],
                height: 230,
                width: 300,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
              ),
            );
          }),
        ],
      ],
    );
  }
}
