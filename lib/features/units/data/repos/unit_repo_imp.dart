import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/unit_repo.dart';
import '../../../../core/sync/app_startup.dart';
import '../data_source/units_local_data_source.dart';
import '../data_source/units_remote_data_source.dart';
import '../models/unit_model.dart';

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
      await AppStartup.instance.runOnce();

      // Try to get data from cache first
      final List<UnitModel>? cached = await unitsLocalDataSource
          .getUnits();
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<UnitModel> units = await unitsRemoteDataSource
          .getUnits();

      // Cache the data
      await unitsLocalDataSource.cacheUnits(units);

      return Right(units);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
