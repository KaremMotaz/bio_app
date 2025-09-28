import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manager/unit_cubit/unit_cubit.dart';
import 'widgets/unit_view_body.dart';

class UnitView extends StatelessWidget {
  const UnitView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: BlocBuilder<UnitCubit, UnitState>(
          builder: (context, state) {
            switch (state) {
              case UnitLoadingState():
                return const UnitViewBody(units: [], isLoading: true);

              case UnitLoadedState():
                return UnitViewBody(units: state.units);

              case UnitErrorState(:final message):
                return Center(child: Text(message));

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
