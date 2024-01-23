part of 'history_attendance_bloc.dart';

@freezed
class HistoryAttendanceEvent with _$HistoryAttendanceEvent {
  const factory HistoryAttendanceEvent.initDate({
    required UserEntity userEntity,
  }) = _InitDate;
  const factory HistoryAttendanceEvent.changeDate({
    required DateTime startDatetime,
    required DateTime endDatetime,
  }) = _ChangeDate;
  const factory HistoryAttendanceEvent.getListAttendance() = _GetListAttendance;
}
