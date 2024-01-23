import 'package:attendance_app/modules/attendance/domain/entities/list_attendance_params.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../../../common/usecases/usecase.dart';
import '../entities/attendance_entity.codegen.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class GetListAttendanceUseCase
    extends UseCase<List<AttendanceEntity>, ListAttendanceParams> {
  final AttendanceRepository _repository;

  const GetListAttendanceUseCase(this._repository);

  @override
  Future<Either<AppError, List<AttendanceEntity>>> call(
      ListAttendanceParams params) {
    return _repository.getListAttendance(params);
  }
}
