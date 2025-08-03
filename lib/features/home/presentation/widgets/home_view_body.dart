import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/home/presentation/widgets/units_cards_list.dart';
import 'package:bio_app/features/home/presentation/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(Routes.profileView);
                },
                child: const CustomCircleAvatar(),
              ),
            ),
            Text(
              "اهلا بك...احمد",
              style: TextStyles.bold20.copyWith(
                color: AppColors.moreDarkerBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "مستعد للتحدى؟!",
              style: TextStyles.bold28.copyWith(
                color: AppColors.mainpurple,
              ),
            ),
            const SizedBox(height: 46),
            const UnitsCardsList(),
          ],
        ),
      ),
    );
  }
}
