import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../data/models/unit_model.dart';

abstract class UnitRepo {
  Future<Either<Failure, List<UnitModel>>> getUnits();
}
