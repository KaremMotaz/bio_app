import '../../../core/errors/failure.dart';
import '../data/models/unit_model.dart';
import 'package:dartz/dartz.dart';

abstract class UnitRepo {
  Future<Either<Failure, List<UnitModel>>> getUnits();
}
