import 'package:dartz/dartz.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../../../common/usecases/usecase.dart';
import '../entities/place_search_entity.codegen.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class ConvertCoordinateToAddressUseCase
    extends UseCase<PlaceSearchEntity, GeoPoint> {
  final AttendanceRepository _repository;

  const ConvertCoordinateToAddressUseCase(this._repository);

  @override
  Future<Either<AppError, PlaceSearchEntity>> call(GeoPoint params) {
    return _repository.convertCoordinateToAddress(params);
  }
}
