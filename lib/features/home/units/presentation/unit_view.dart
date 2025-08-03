import 'widgets/unit_view_body.dart';
import 'package:flutter/material.dart';

class UnitView extends StatelessWidget {
  const UnitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: UnitViewBody());
  }
}
