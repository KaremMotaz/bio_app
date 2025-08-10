import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/units/data/models/unit_model.dart';
import 'package:dartz/dartz.dart';

import '../../../data/repos/unit_repo_imp.dart';
import '../../../domain/unit_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit({required this.unitRepoImpl}) : super(UnitInitialState());
  final UnitRepoImpl unitRepoImpl;

  Future<void> getUnits() async {
    emit(UnitLoadingState());
    
    final Either<Failure, List<UnitModel>> result = await unitRepoImpl
        .getUnits();

    result.fold(
      (failure) => emit(UnitErrorState(message: failure.errMessage)),
      (units) {
        final unitEntities = units
            .map((model) => model.toEntity())
            .toList();
        emit(UnitLoadedState(units: unitEntities));
      },
    );
  }
}
