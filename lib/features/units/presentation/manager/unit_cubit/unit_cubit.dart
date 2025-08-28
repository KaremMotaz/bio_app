import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/repos/unit_repo_imp.dart';
import '../../../domain/unit_entity.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  final UnitRepoImpl unitRepoImpl;

  UnitCubit({required this.unitRepoImpl}) : super(UnitInitialState());

  Future<void> getUnits() async {
    if (isClosed) return; 

    emit(UnitLoadingState());

    final Either<Failure, List<UnitModel>> result =
        await unitRepoImpl.getUnits();

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(UnitErrorState(message: failure.message));
      },
      (units) {
        if (isClosed) return;
        final unitEntities = units.map((model) => model.toEntity()).toList();
        emit(UnitLoadedState(units: unitEntities));
      },
    );
  }

  @override
  Future<void> close() {
    // لو عندك أي subscriptions (مثلاً listener على الإنترنت) تلغيها هنا
    return super.close();
  }
}
