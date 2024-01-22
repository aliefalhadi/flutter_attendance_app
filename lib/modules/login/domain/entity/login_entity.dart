// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.freezed.dart';
part 'login_entity.g.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required String email,
    required String password,
  }) = _LoginEntity;

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);
}
