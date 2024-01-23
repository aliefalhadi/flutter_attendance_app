part of 'attendance_home_bloc.dart';

enum AttendanceHomeStatus { initial, loading, loaded, failure, failureLocation }

@freezed
class AttendanceHomeState with _$AttendanceHomeState {
  const factory AttendanceHomeState({
    @Default([]) List<AttendanceEntity> listAttendance,
    DateTime? dateTimeNow,
    @Default(AttendanceHomeStatus.initial) AttendanceHomeStatus status,
  }) = _AttendanceHomeState;
}

extension AttendanceHomeStateX on AttendanceHomeState {
  bool isClockIn() {
    return listAttendance.length % 2 == 0;
  }
}
