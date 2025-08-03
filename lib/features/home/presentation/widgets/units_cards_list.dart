import 'package:bio_app/features/home/data/models/unit_model.dart';
import 'package:bio_app/features/home/presentation/widgets/custom_unit_card.dart';
import 'package:flutter/material.dart';

class UnitsCardsList extends StatelessWidget {
  const UnitsCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final units = UnitModel.units;

    return Column(
      children: List.generate(units.length, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: index == 1 ? 70 : 0,
          ),
          child: CustomUnitCard(unit: units[index]),
        );
      }),
    );
  }
}
