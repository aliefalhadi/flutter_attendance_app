import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../../common/constants/app_error.dart';
import '../entities/place_search_entity.codegen.dart';

abstract class AttendanceRepository {
  Future<Either<AppError, PlaceSearchEntity>> convertCoordinateToAddress(
    GeoPoint latLng,
  );
}
