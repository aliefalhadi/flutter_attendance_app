// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

@freezed
class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    int? status,
    bool? success,
    Data? data,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    User? user,
    String? token,
    String? tokenType,
    DateTime? expiresAt,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    String? id,
    String? name,
    String? email,
    String? role,
    String? companyId,
    Company? company,
    Employee? employee,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Company with _$Company {
  const factory Company({
    String? id,
    String? companyName,
    dynamic logo,
    List<dynamic>? media,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

@freezed
class Employee with _$Employee {
  const factory Employee({
    int? id,
    String? employeeId,
    String? userId,
    String? employeeFirstName,
    String? employeeLastName,
    dynamic employeeImg,
    dynamic employeeDepartment,
    String? fullName,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}

extension LoginResponseModelX on LoginResponseModel {
  UserEntity toDomain() {
    return UserEntity(
      name: data?.user?.name,
      email: data?.user?.name,
      id: data?.user?.id,
      company: CompanyEntity(
        id: data?.user?.company?.id,
        companyName: data?.user?.company?.companyName,
        logo: data?.user?.company?.logo,
        media: data?.user?.company?.media,
      ),
      companyId: data?.user?.companyId,
      employee: EmployeeEntity(
        id: data?.user?.employee?.id,
        fullName: data?.user?.employee?.fullName,
        employeeDepartment: data?.user?.employee?.employeeDepartment,
        employeeFirstName: data?.user?.employee?.employeeFirstName,
        employeeId: data?.user?.employee?.employeeId,
        employeeImg: data?.user?.employee?.employeeImg,
        employeeLastName: data?.user?.employee?.employeeLastName,
        userId: data?.user?.employee?.userId,
      ),
      role: data?.user?.role,
    );
  }
}
