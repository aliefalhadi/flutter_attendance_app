import 'dart:convert';

import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUserLogin(UserEntity userLogin);
  Future<UserEntity?> getUserLogin();
  Future<bool> deleteUserLogin();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences _preferences;

  AuthLocalDataSourceImpl(this._preferences);

  @override
  Future<UserEntity?> getUserLogin() async {
    String? userData = _preferences.getString("user");

    if (userData == null) {
      return null;
    }

    return UserEntity.fromJson(jsonDecode(userData));
  }

  @override
  Future<void> saveUserLogin(UserEntity userLogin) async {
    _preferences.setString("user", jsonEncode(userLogin));
  }

  @override
  Future<bool> deleteUserLogin() async {
    await _preferences.clear();

    return true;
  }
}
