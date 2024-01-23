import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../../../common/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class UploadImageUseCase extends UseCase<String, String> {
  final AttendanceRepository _repository;

  const UploadImageUseCase(this._repository);

  @override
  Future<Either<AppError, String>> call(String params) {
    return _repository.uploadImage(params);
  }
}
