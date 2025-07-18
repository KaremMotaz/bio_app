import '../../../../../core/theming/text_styles.dart';

import '../../../../../core/theming/app_colors.dart';
import 'fill_profile_form.dart';
import 'package:flutter/material.dart';

class FillProfileViewBody extends StatelessWidget {
  const FillProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            SizedBox(height: 8),
            Text(
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
