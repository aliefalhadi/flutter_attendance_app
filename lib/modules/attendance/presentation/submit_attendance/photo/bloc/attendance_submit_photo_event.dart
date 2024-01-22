part of 'attendance_submit_photo_bloc.dart';

@freezed
class AttendanceSubmitPhotoEvent with _$AttendanceSubmitPhotoEvent {
  const factory AttendanceSubmitPhotoEvent.initData({
    GeoPoint? latLngAddress,
    String? placeAddressName,
    required bool isClockIn,
  }) = _InitData;

  const factory AttendanceSubmitPhotoEvent.takePhoto({
    required CameraController cameraController,
  }) = _TakePhoto;

  const factory AttendanceSubmitPhotoEvent.uploadImage() = _UploadImage;

  const factory AttendanceSubmitPhotoEvent.submitAttendance({
    required String urlImageUploaded,
  }) = _SubmitAttendance;
}
