import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsCard extends StatelessWidget {
  const TermsAndConditionsCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      color: AppColors.grey100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.bold16),
            const SizedBox(height: 8),
            Text(content, style: TextStyles.medium14),
          ],
        ),
      ),
    );
  }
}
