import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/get_user.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../domain/unit_entity.dart';
import 'units_cards_list.dart';

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
                child: UserAvatar(
                  name: getUser().firstName!,
                  savedColor: getUser().avatarColor!,
                  imageUrl: getUser().imageUrl,
                  fontSize: 28,
                  radius: 28,
                ),
              ),
            ),
            Text(
              "أهلاً بك ${getUser().firstName}!",
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
