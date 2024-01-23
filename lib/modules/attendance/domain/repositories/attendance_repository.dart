import 'package:attendance_app/modules/attendance/domain/entities/post_attendance_params.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../../common/constants/app_error.dart';
import '../entities/place_search_entity.codegen.dart';

abstract class AttendanceRepository {
  Future<Either<AppError, PlaceSearchEntity>> convertCoordinateToAddress(
    GeoPoint latLng,
  );
  Future<Either<AppError, bool>> submitAttendance(
    SubmitAttendanceParams params,
  );
  Future<Either<AppError, String>> uploadImage(String imagePath);
}
