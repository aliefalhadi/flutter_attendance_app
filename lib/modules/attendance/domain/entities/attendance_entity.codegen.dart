// To parse this JSON data, do
//
//     final attendanceEntity = attendanceEntityFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_entity.codegen.freezed.dart';
part 'attendance_entity.codegen.g.dart';

@freezed
class AttendanceEntity with _$AttendanceEntity {
  const factory AttendanceEntity({
    int? isLate,
    String? companyId,
    String? userId,
    double? latitude,
    String? location,
    String? urlFaceLog,
    int? attendanceTime,
    String? type,
    double? longitude,
  }) = _AttendanceEntity;

  factory AttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEntityFromJson(json);
}

extension AttendanceEntityX on AttendanceEntity {
  DateTime toAttendanceTime() {
    return DateTime.fromMicrosecondsSinceEpoch(attendanceTime! * 1000);
  }
}
