import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/unit_repo.dart';
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
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } on PlatformException catch (e) {
      return Left(ServerFailure.fromPlatformException(e));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure.unknown(e.toString()));
    }
  }
}
