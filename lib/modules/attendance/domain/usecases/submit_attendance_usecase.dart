import 'package:attendance_app/modules/attendance/domain/entities/post_attendance_params.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../../../common/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class SubmitAttendanceUseCase extends UseCase<bool, SubmitAttendanceParams> {
  final AttendanceRepository _repository;

  const SubmitAttendanceUseCase(this._repository);

  @override
  Future<Either<AppError, bool>> call(SubmitAttendanceParams params) {
    return _repository.submitAttendance(params);
  }
}
