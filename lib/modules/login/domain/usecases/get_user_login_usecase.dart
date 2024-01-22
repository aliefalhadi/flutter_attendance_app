import 'package:attendance_app/common/usecases/no_params_usecase.dart';
import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetUserLoginUseCase extends NoParamsUseCase<UserEntity?> {
  final AuthRepository _repository;

  GetUserLoginUseCase(this._repository);

  @override
  Future<Either<AppError, UserEntity?>> call() {
    return _repository.getUserLogin();
  }
}
