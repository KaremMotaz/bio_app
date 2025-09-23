import 'home_appbar.dart';
import 'package:flutter/material.dart';
import '../../domain/unit_entity.dart';
import 'units_cards_list.dart';

class UnitViewBody extends StatelessWidget {
  const UnitViewBody({super.key, required this.units});
  final List<UnitEntity> units;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppbar(),
          const SizedBox(height: 46),
          Padding(
            padding: const EdgeInsets.all(16),
            child: UnitsCardsList(units: units),
          ),
        ],
      ),
    );
  }
}
