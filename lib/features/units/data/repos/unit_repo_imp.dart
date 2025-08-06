import 'dart:developer';
import '../../../../core/errors/server_failure.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/units_remote_data_source.dart';
import '../data_source/units_local_data_source.dart';
import '../models/unit_model.dart';
import '../../domain/unit_repo.dart';
import 'package:dartz/dartz.dart';

class UnitRepoImpl implements UnitRepo {
  final UnitsRemoteDataSource unitsRemoteDataSource;
  final UnitsLocalDataSource unitsLocalDataSource;

  UnitRepoImpl({
    required this.unitsRemoteDataSource,
    required this.unitsLocalDataSource,
  });

  @override
  Future<Either<Failure, List<UnitModel>>> getUnits() async {
    try {
      // Try to get from cache first
      final cached = await unitsLocalDataSource.getUnits();
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final result = await unitsRemoteDataSource.getUnits();
      final units = result
          .map((json) => UnitModel.fromJson(json))
          .toList();

      // Cache the data
      await unitsLocalDataSource.cacheUnits(units);

      return Right(units);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
