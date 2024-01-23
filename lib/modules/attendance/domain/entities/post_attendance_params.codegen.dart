// To parse this JSON data, do
//
//     final postAttendanceParams = postAttendanceParamsFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_attendance_params.codegen.freezed.dart';
part 'post_attendance_params.codegen.g.dart';

@freezed
class SubmitAttendanceParams with _$SubmitAttendanceParams {
  const factory SubmitAttendanceParams({
    required String userId,
    required int attendanceTime,
    required String companyId,
    required String urlFaceLog,
    @Default('') String? location,
    @Default(0) double? latitude,
    @Default(0) double? longitude,
    required String type,
    required int isLate,
  }) = _SubmitAttendanceParams;

  factory SubmitAttendanceParams.fromJson(Map<String, dynamic> json) =>
      _$SubmitAttendanceParamsFromJson(json);
}
