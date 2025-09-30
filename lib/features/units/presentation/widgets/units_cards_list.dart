import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/unit_entity.dart';
import 'custom_unit_card.dart';

class UnitsCardsList extends StatelessWidget {
  const UnitsCardsList({
    super.key,
    required this.units,
    this.isLoading = false,
  });
  final List<UnitEntity> units;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: List.generate(units.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 20 : 70,
              bottom: index == units.length - 1 ? 100 : 0,
            ),
            child: CustomUnitCard(unit: units[index]),
          );
        }),
      ),
    );
  }
}
