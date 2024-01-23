part of 'attendance_submit_location_bloc.dart';

@freezed
class AttendanceSubmitLocationEvent with _$AttendanceSubmitLocationEvent {
  const factory AttendanceSubmitLocationEvent.getLocation() = _GetLocation;

  const factory AttendanceSubmitLocationEvent.getAddress({
    required GeoPoint latLng,
  }) = _GetAddress;
}
