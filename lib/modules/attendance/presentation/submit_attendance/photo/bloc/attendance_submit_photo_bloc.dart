import 'dart:async';
import 'dart:io';

import 'package:attendance_app/modules/attendance/domain/entities/post_attendance_params.codegen.dart';
import 'package:attendance_app/modules/attendance/domain/usecases/upload_image_usecase.dart';
import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/submit_attendance_usecase.dart';

part 'attendance_submit_photo_bloc.freezed.dart';
part 'attendance_submit_photo_event.dart';
part 'attendance_submit_photo_state.dart';

@injectable
class AttendanceSubmitPhotoBloc
    extends Bloc<AttendanceSubmitPhotoEvent, AttendanceSubmitPhotoState> {
  final UploadImageUseCase _uploadImageUseCase;
  final SubmitAttendanceUseCase _submitAttendanceUseCase;

  AttendanceSubmitPhotoBloc(
    this._submitAttendanceUseCase,
    this._uploadImageUseCase,
  ) : super(const AttendanceSubmitPhotoState()) {
    on<_InitData>(_onInitData);
    on<_UploadImage>(_onUploadImage);
    on<_SubmitAttendance>(_onSubmitAttendance);
    on<_TakePhoto>(_onTakePhoto);
  }

  FutureOr<void> _onInitData(_InitData event, emit) async {
    DateTime dateTimeNow = DateTime.now();

    emit(
      state.copyWith(
        dateTimeNow: dateTimeNow,
        latLngAddress: event.latLngAddress,
        placeAddressName: event.placeAddressName,
        isClockIn: event.isClockIn,
        userEntity: event.userEntity,
      ),
    );
  }

  FutureOr<void> _onTakePhoto(_TakePhoto event, emit) async {
    emit(state.copyWith(statusTakePhoto: AttendanceTakePhotoStatus.loading));

    final filePathPhoto = await takePicture(event.cameraController);

    if (filePathPhoto == null) {
      emit(state.copyWith(statusTakePhoto: AttendanceTakePhotoStatus.failure));
    } else {
      emit(
        state.copyWith(
          statusTakePhoto: AttendanceTakePhotoStatus.loaded,
          filePathPhoto: filePathPhoto,
        ),
      );
    }
  }

  FutureOr<void> _onUploadImage(_UploadImage event, emit) async {
    emit(
      state.copyWith(
        status: AttendanceSubmitPhotoStatus.loading,
      ),
    );

    final res = await _uploadImageUseCase(state.filePathPhoto);

    res.fold(
      (l) => emit(state.copyWith(status: AttendanceSubmitPhotoStatus.failure)),
      (image) {
        add(
          _SubmitAttendance(urlImageUploaded: image),
        );
      },
    );
  }

  //
  FutureOr<void> _onSubmitAttendance(_SubmitAttendance event, emit) async {
    DateTime? dateTimeLocationNow = DateTime.now();
    final isLate = dateTimeLocationNow.isAfter(DateTime(
        dateTimeLocationNow.year,
        dateTimeLocationNow.month,
        dateTimeLocationNow.day,
        8,
        0,
        0));
    final res = await _submitAttendanceUseCase(SubmitAttendanceParams(
      urlFaceLog: event.urlImageUploaded,
      type: state.isClockIn! ? 'clockin' : 'clockout',
      companyId: state.userEntity!.companyId!,
      userId: state.userEntity!.id!,
      attendanceTime: dateTimeLocationNow.millisecondsSinceEpoch,
      latitude: state.latLngAddress?.latitude ?? 0,
      longitude: state.latLngAddress?.longitude ?? 0,
      location: state.placeAddressName ?? '',
      isLate: isLate ? 1 : 0,
    ));

    res.fold(
      (l) {
        emit(state.copyWith(status: AttendanceSubmitPhotoStatus.failure));
      },
      (data) {
        emit(state.copyWith(
          status: AttendanceSubmitPhotoStatus.loaded,
          dateTimeAttendance: dateTimeLocationNow,
        ));
      },
    );
  }
}

Future<String?> takePicture(CameraController controller) async {
  if (!controller.value.isInitialized) {
    return null;
  }
  if (controller.value.isTakingPicture) {
    return null;
  }
  try {
    await controller.setFlashMode(FlashMode.off);

    XFile picture = await controller.takePicture();

    controller.pausePreview();

    File? fixedFile;
    if (controller.description.lensDirection == CameraLensDirection.front) {
      final imageBytes = await picture.readAsBytes();

      img.Image? originalImage = img.decodeImage(imageBytes);
      img.Image? fixedImage = img.flipHorizontal(originalImage!);

      File file = File(picture.path);
      fixedFile = await file.writeAsBytes(
        img.encodeJpg(fixedImage),
        flush: true,
      );
    }

    return fixedFile == null ? picture.path : fixedFile.path;
  } on CameraException catch (e) {
    debugPrint('Error occured while taking picture: $e');

    return null;
  }
}
