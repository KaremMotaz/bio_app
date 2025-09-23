import '../../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class ExamResultListTile extends StatelessWidget {
  const ExamResultListTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color.withAlpha(30),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Text(title, style: TextStyles.medium16),
        const Spacer(),
        Text(value, style: TextStyles.bold18.copyWith(color: color)),
      ],
    );
  }
}
