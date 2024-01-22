// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? id,
    String? name,
    String? email,
    String? role,
    String? companyId,
    CompanyEntity? company,
    EmployeeEntity? employee,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

@freezed
class CompanyEntity with _$CompanyEntity {
  const factory CompanyEntity({
    String? id,
    String? companyName,
    dynamic logo,
    List<dynamic>? media,
  }) = _CompanyEntity;

  factory CompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntityFromJson(json);
}

@freezed
class EmployeeEntity with _$EmployeeEntity {
  const factory EmployeeEntity({
    int? id,
    String? employeeId,
    String? userId,
    String? employeeFirstName,
    String? employeeLastName,
    dynamic employeeImg,
    dynamic employeeDepartment,
    String? fullName,
  }) = _EmployeeEntity;

  factory EmployeeEntity.fromJson(Map<String, dynamic> json) =>
      _$EmployeeEntityFromJson(json);
}
