part of 'attendance_submit_photo_bloc.dart';

enum AttendanceSubmitPhotoStatus { initial, loading, loaded, failure }

enum AttendanceTakePhotoStatus { initial, loading, loaded, failure }

@freezed
class AttendanceSubmitPhotoState with _$AttendanceSubmitPhotoState {
  const factory AttendanceSubmitPhotoState({
    UserEntity? userEntity,
    GeoPoint? latLngAddress,
    String? placeAddressName,
    bool? isClockIn,
    DateTime? dateTimeNow,
    DateTime? dateTimeAttendance,
    @Default('') String filePathPhoto,
    @Default(AttendanceTakePhotoStatus.initial)
    AttendanceTakePhotoStatus statusTakePhoto,
    @Default(AttendanceSubmitPhotoStatus.initial)
    AttendanceSubmitPhotoStatus status,
  }) = _AttendanceSubmitPhotoState;
}
