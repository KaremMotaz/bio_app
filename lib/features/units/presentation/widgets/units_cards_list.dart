import 'package:bio_app/features/units/domain/unit_entity.dart';
import 'custom_unit_card.dart';
import 'package:flutter/material.dart';

class UnitsCardsList extends StatelessWidget {
  const UnitsCardsList({super.key, required this.units});
  final List<UnitEntity> units;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(units.length, (index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 70),
          child: CustomUnitCard(unit: units[index]),
        );
      }),
    );
  }
}
