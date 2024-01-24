import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/constants/app_error.dart';
import '../entity/login_entity.dart';

abstract class AuthRepository {
  Future<Either<AppError, bool>> postLogin(LoginEntity loginEntity);
  Future<Either<AppError, UserEntity?>> getUserLogin();
  Future<Either<AppError, bool>> deleteUserLogin();
}
