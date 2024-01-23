import 'package:attendance_app/modules/attendance/data/models/geo_coding_response_model.codegen.dart';
import 'package:attendance_app/modules/attendance/domain/entities/list_attendance_params.codegen.dart';
import 'package:attendance_app/modules/attendance/domain/entities/post_attendance_params.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../domain/entities/attendance_entity.codegen.dart';
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

  @override
  Future<Either<AppError, bool>> submitAttendance(
      SubmitAttendanceParams params) async {
    try {
      final res = await _remoteDataSource.submitAttendance(params);

      return Right(res);
    } on Exception catch (e, _) {
      return Left(AppError('Error $e'));
    } catch (e, _) {
      return Left(AppError('Error $e'));
    }
  }

  @override
  Future<Either<AppError, String>> uploadImage(String imagePath) async {
    try {
      final res = await _remoteDataSource.uploadImage(imagePath);

      return Right(res);
    } on Exception catch (e, _) {
      return Left(AppError('Error $e'));
    } catch (e, _) {
      return Left(AppError('Error $e'));
    }
  }

  @override
  Future<Either<AppError, List<AttendanceEntity>>> getListAttendance(
      ListAttendanceParams attendanceParams) async {
    try {
      final res = await _remoteDataSource.getListAttendance(attendanceParams);

      return Right(res);
    } on Exception catch (e, _) {
      return Left(AppError('Error $e'));
    } catch (e, _) {
      return Left(AppError('Error $e'));
    }
  }
}
