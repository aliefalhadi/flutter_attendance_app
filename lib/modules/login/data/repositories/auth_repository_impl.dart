import 'package:attendance_app/modules/login/data/datasources/auth_local_data_source.dart';
import 'package:attendance_app/modules/login/data/datasources/auth_remote_data_source.dart';
import 'package:attendance_app/modules/login/data/models/login_response_model.dart';
import 'package:attendance_app/modules/login/domain/entity/login_entity.dart';
import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/app_error.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<AppError, bool>> postLogin(LoginEntity loginEntity) async {
    try {
      final res = await _remoteDataSource.postLogin(loginEntity);

      print('asd');
      print(res);

      _localDataSource.saveUserLogin(res.toDomain());

      return const Right(true);
    } on Exception catch (e, _) {
      print(e);
      return Left(AppError('Error $e'));
    } catch (e, _) {
      print(e);

      return Left(AppError('Error $e'));
    }
  }

  @override
  Future<Either<AppError, UserEntity?>> getUserLogin() async {
    try {
      final res = await _localDataSource.getUserLogin();

      return Right(res);
    } on Exception catch (e, _) {
      return Left(AppError('Error $e'));
    } catch (e, _) {
      return Left(AppError('Error $e'));
    }
  }

  @override
  Future<Either<AppError, bool>> deleteUserLogin() async {
    try {
      final res = await _localDataSource.deleteUserLogin();

      return Right(res);
    } on Exception catch (e, _) {
      return Left(AppError('Error $e'));
    } catch (e, _) {
      return Left(AppError('Error $e'));
    }
  }
}
