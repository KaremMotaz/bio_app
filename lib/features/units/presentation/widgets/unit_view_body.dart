import 'home_appbar.dart';
import 'package:flutter/material.dart';
import '../../domain/unit_entity.dart';
import 'units_cards_list.dart';

class UnitViewBody extends StatelessWidget {
  const UnitViewBody({
    super.key,
    required this.units,
    this.isLoading = false,
  });
  final List<UnitEntity> units;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppbar(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: UnitsCardsList(units: units, isLoading: isLoading),
          ),
        ],
      ),
    );
  }
}
