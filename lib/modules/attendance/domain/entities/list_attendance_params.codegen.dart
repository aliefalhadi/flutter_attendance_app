import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_attendance_params.codegen.freezed.dart';
part 'list_attendance_params.codegen.g.dart';

@freezed
class ListAttendanceParams with _$ListAttendanceParams {
  const factory ListAttendanceParams({
    required String startDate,
    required String endDate,
    required String userId,
    required String companyId,
  }) = _ListAttendanceParams;

  factory ListAttendanceParams.fromJson(Map<String, dynamic> json) =>
      _$ListAttendanceParamsFromJson(json);
}
