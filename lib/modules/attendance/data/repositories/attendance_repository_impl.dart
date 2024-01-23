import 'package:attendance_app/modules/attendance/data/models/geo_coding_response_model.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../domain/entities/place_search_entity.codegen.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImpl extends AttendanceRepository {
  final AttendanceRemoteDataSource _remoteDataSource;

  AttendanceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AppError, PlaceSearchEntity>> convertCoordinateToAddress(
    GeoPoint latLng,
  ) async {
    try {
      final geoCodingResponseModel =
          await _remoteDataSource.convertCoordinateToAddress(latLng);

      return Right(geoCodingResponseModel.toDomain(latLng));
    } on Exception catch (e, _) {
      return Left(AppError('Error $e'));
    } catch (e, _) {
      return Left(AppError('Error $e'));
    }
  }
}
