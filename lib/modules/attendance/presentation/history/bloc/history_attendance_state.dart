part of 'history_attendance_bloc.dart';

enum HistoryAttendanceStatus {
  initial,
  loading,
  loaded,
  failure,
  failureLocation
}

@freezed
class HistoryAttendanceState with _$HistoryAttendanceState {
  const factory HistoryAttendanceState({
    DateTime? selectedDateStart,
    DateTime? selectedDateEnd,
    UserEntity? userEntity,
    @Default([]) List<AttendanceEntity> listAttendance,
    @Default(HistoryAttendanceStatus.initial) HistoryAttendanceStatus status,
  }) = _HistoryAttendanceState;
}
