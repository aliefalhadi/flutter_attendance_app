import 'package:attendance_app/modules/login/data/models/login_response_model.dart';
import 'package:attendance_app/modules/login/domain/entity/login_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> postLogin(LoginEntity loginEntity);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponseModel> postLogin(LoginEntity loginEntity) async {
    final res = await _dio.post("/login", data: loginEntity.toJson());

    return LoginResponseModel.fromJson(res.data);
  }
}
