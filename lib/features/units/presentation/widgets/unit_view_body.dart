import 'package:bio_app/features/units/domain/unit_entity.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import 'units_cards_list.dart';
import 'custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnitViewBody extends StatelessWidget {
  const UnitViewBody({super.key, required this.units});
  final List<UnitEntity> units;

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
            UnitsCardsList(units: units),
          ],
        ),
      ),
    );
  }
}
