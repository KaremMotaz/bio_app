import 'package:flutter/material.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';
import 'fill_profile_form.dart';

class FillProfileViewBody extends StatelessWidget {
  const FillProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "املأ ملفك الشخصي",
                style: TextStyles.bold20.copyWith(color: AppColors.mainBlue),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "يرجى قضاء بضع دقائق في ملء ملفك الشخصي بأكبر قدر ممكن من التفاصيل.",
              style: TextStyles.regular14,
            ),
            const FillProfileForm(),
          ],
        ),
      ),
    );
  }
}
