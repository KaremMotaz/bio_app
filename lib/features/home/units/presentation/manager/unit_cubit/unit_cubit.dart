import 'package:bio_app/features/home/units/data/models/unit_model.dart';
import 'package:bio_app/features/home/units/data/repos/unit_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit({required this.unitRepoImpl}) : super(UnitInitialState());
  final UnitRepoImpl unitRepoImpl;

  Future<void> getUnits() async {
    emit(UnitLoadingState());
    final result = await unitRepoImpl.getUnits();
    result.fold(
      (failure) => emit(UnitErrorState(message: failure.errMessage)),
      (units) => emit(UnitLoadedState(units: units)),
    );
  }
}
