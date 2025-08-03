import 'dart:developer';

import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/home/units/data/models/unit_model.dart';
import 'package:bio_app/features/home/units/data/data_source/units_local_data_source.dart';
import 'package:bio_app/features/home/units/domain/unit_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:bio_app/core/errors/failure.dart';

class UnitRepoImpl implements UnitRepo {
  @override
  Future<Either<Failure, List<UnitModel>>> getUnits() async {
    try {
      final List<UnitModel> units = unitsJson
          .map((json) => UnitModel.fromJson(json))
          .toList();
      return Right(units);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
