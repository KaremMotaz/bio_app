import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/units/data/models/unit_model.dart';
import 'package:dartz/dartz.dart';

abstract class UnitRepo {
  Future<Either<Failure, List<UnitModel>>> getUnits();
}
