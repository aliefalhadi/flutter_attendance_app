part of 'attendance_home_bloc.dart';

@freezed
class AttendanceHomeEvent with _$AttendanceHomeEvent {
  const factory AttendanceHomeEvent.getListAttendanceToday({
    required UserEntity userEntity,
  }) = _GetListAttendanceToday;
}
