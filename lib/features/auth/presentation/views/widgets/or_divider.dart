import 'package:flutter/material.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.lightGray)),
        SizedBox(width: 10),
        Text("أو", style: TextStyles.regular14),

        SizedBox(width: 10),
        Expanded(child: Divider(color: AppColors.lightGray)),
      ],
    );
  }
}
