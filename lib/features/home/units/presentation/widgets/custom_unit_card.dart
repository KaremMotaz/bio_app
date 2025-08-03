import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/assets_data.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../data/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CustomUnitCard extends StatelessWidget {
  const CustomUnitCard({super.key, required this.unit});
  final UnitModel unit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(Routes.chaptersView);
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
                colors: unit.colorList,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(70),
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
                  backgroundColor: Colors.white.withAlpha(70),
                  child: SvgPicture.asset(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    AssetsData.openIcon,
                    width: 14,
                    height: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "الباب ${unit.number}",
                  style: TextStyles.bold14.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  unit.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bold20.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: -45,
            left: 30,
            child: Image.asset(unit.image, width: 128, height: 126),
          ),
        ],
      ),
    );
  }
}
