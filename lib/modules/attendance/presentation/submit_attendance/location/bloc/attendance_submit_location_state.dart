part of 'attendance_submit_location_bloc.dart';

enum AttendanceSubmitLocationStatus {
  initial,
  loading,
  loaded,
  failure,
  failureLocation
}

@freezed
class AttendanceSubmitLocationState with _$AttendanceSubmitLocationState {
  const factory AttendanceSubmitLocationState({
    PlaceSearchEntity? placeSearchEntity,
    GeoPoint? coordinateLocation,
    @Default(AttendanceSubmitLocationStatus.initial)
    AttendanceSubmitLocationStatus status,
  }) = _AttendanceSubmitLocationState;
}
