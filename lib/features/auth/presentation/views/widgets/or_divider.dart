import '../../../../../core/theming/text_styles.dart';

import '../../../../../core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.lightGray)),
        SizedBox(width: 10),
        Text("أو", style: TextStyles.regular14),

        SizedBox(width: 10),
        const Expanded(child: Divider(color: AppColors.lightGray)),
      ],
    );
  }
}
