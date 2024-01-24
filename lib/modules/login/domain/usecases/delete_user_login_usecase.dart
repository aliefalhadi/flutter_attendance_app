import 'package:attendance_app/common/usecases/no_params_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class DeleteUserLoginUseCase extends NoParamsUseCase<bool> {
  final AuthRepository _repository;

  DeleteUserLoginUseCase(this._repository);

  @override
  Future<Either<AppError, bool>> call() {
    return _repository.deleteUserLogin();
  }
}
