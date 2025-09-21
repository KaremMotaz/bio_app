import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/unit_entity.dart';

class CustomUnitCard extends StatelessWidget {
  const CustomUnitCard({super.key, required this.unit});
  final UnitEntity unit;

  @override
  Widget build(BuildContext context) {
    final List<Color> colorPair =
        AppColors.predefinedColorPairsForUnits[unit.colorIndex];

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(Routes.chaptersView, extra: unit);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colorPair[0], colorPair[1]],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(70),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.white.withAlpha(70),
                  child: SvgPicture.asset(
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                    AssetsData.openIcon,
                    width: 14,
                    height: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "الباب ${getDisplayNumber(unit.index)}",
                  style: TextStyles.bold14.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  unit.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bold20.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: -45,
            left: 30,
            child: CachedNetworkImage(
              imageUrl: unit.image,
              width: 128,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
