import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../../../common/usecases/usecase.dart';
import '../entity/login_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class PostLoginUseCase extends UseCase<bool, LoginEntity> {
  final AuthRepository _repository;

  PostLoginUseCase(this._repository);

  @override
  Future<Either<AppError, bool>> call(params) async {
    return _repository.postLogin(params);
  }
}
