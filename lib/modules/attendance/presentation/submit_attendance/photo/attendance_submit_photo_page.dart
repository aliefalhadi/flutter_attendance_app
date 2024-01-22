import 'package:attendance_app/common/extentions/modal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../common/di_module/init_config.dart';
import '../../../../../common/util/dialog_helper.dart';
import 'bloc/attendance_submit_photo_bloc.dart';
import 'sections/info_location_attendance.dart';
import 'sections/preview_photo.dart';

@RoutePage()
class AttendanceSubmitPhotoPage extends StatefulWidget {
  const AttendanceSubmitPhotoPage({
    Key? key,
    this.latLngLocation,
    this.placeAddressName,
    required this.isClockIn,
  }) : super(key: key);

  final GeoPoint? latLngLocation;
  final String? placeAddressName;
  final bool isClockIn;

  @override
  State<AttendanceSubmitPhotoPage> createState() =>
      _AttendanceSubmitPhotoPageState();
}

class _AttendanceSubmitPhotoPageState extends State<AttendanceSubmitPhotoPage>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription> cameras = [];
  late AttendanceSubmitPhotoBloc _submitPhotoBloc;
  bool isModalPermissionActive = false;
  late PermissionStatus permissionCamera;
  late GlobalKey globalKey;

  Future initCamera(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.medium, enableAudio: false);
    try {
      await _cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  bool isCameraDenied() {
    return permissionCamera.isDenied ||
        permissionCamera.isPermanentlyDenied ||
        permissionCamera.isRestricted;
  }

  Future<bool> _determineCamera() async {
    permissionCamera = await Permission.camera.request();
    if (isCameraDenied()) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    globalKey = GlobalKey();

    _determineCamera().then((value) {
      if (value) {
        availableCameras().then((camerasAvailable) {
          cameras = camerasAvailable;
          initCamera(cameras[1]);
        });
      }
    });
    _submitPhotoBloc = getIt<AttendanceSubmitPhotoBloc>();
    _submitPhotoBloc.add(
      AttendanceSubmitPhotoEvent.initData(
        latLngAddress: widget.latLngLocation,
        placeAddressName: widget.placeAddressName,
        isClockIn: widget.isClockIn,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!isModalPermissionActive) {
      if (state == AppLifecycleState.resumed && isCameraDenied()) {
        _determineCamera().then((value) async {
          if (value) {
            availableCameras().then((camerasAvailable) {
              cameras = camerasAvailable;
              initCamera(cameras[1]);
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _submitPhotoBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AttendanceSubmitPhotoBloc, AttendanceSubmitPhotoState>(
            listenWhen: (prev, next) {
              return prev.status != next.status;
            },
            listener: (context, state) {
              if (state.status == AttendanceSubmitPhotoStatus.loading) {
                DialogHelper.showLoadingDialog(context);
              } else if (state.status == AttendanceSubmitPhotoStatus.loaded) {
                // AutoRouter.of(context).push(
                //   AttendanceSubmitSuccessRoute(
                //     dateTimeAttendance:
                //         state.dateTimeAttendance!.toFormatDateTimeIndonesian(),
                //     locationAttendance: state.placeAddressName,
                //     isClockIn: state.isClockIn!,
                //   ),
                // );
              } else if (state.status == AttendanceSubmitPhotoStatus.failure) {
                Navigator.pop(context);
                // AutoRouter.of(context).push(
                //   AttendanceSubmitErrorRoute(
                //     title: "Gagal Melakukan Absen!",
                //     subtitle:
                //         "Pastikan perangkat terhubung ke jaringan\ninternet dan silakan ulangi kembali",
                //   ),
                // );
              }
            },
          ),
          BlocListener<AttendanceSubmitPhotoBloc, AttendanceSubmitPhotoState>(
            listenWhen: (prev, next) {
              return prev.statusTakePhoto != next.statusTakePhoto;
            },
            listener: (context, state) {
              if (state.statusTakePhoto == AttendanceTakePhotoStatus.loading) {
                DialogHelper.showLoadingDialog(context);
              } else if (state.statusTakePhoto ==
                  AttendanceTakePhotoStatus.failure) {
                Navigator.pop(context);
              } else if (state.statusTakePhoto ==
                  AttendanceTakePhotoStatus.loaded) {
                if (globalKey.currentState?.context != null) {
                  Navigator.pop(globalKey.currentState!.context);
                  globalKey.currentState!.context.showBottomSheetModal(
                    isDismissible: false,
                    child: PreviewPhoto(
                      imagePath: state.filePathPhoto,
                      onClickTryAgain: () {
                        Navigator.pop(globalKey.currentState!.context);
                        _cameraController!.resumePreview();
                      },
                      onClickSuccess: () {
                        _submitPhotoBloc.add(
                          const AttendanceSubmitPhotoEvent.uploadImage(),
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
        ],
        child: Scaffold(
          key: globalKey,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              '${widget.isClockIn ? "Absen Masuk" : "Absen Keluar"} • Ambil Foto',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  initCamera(_cameraController!.description.lensDirection ==
                          CameraLensDirection.front
                      ? cameras.first
                      : cameras[1]);
                },
              ),
            ],
          ),
          body: PreviewPhotoContent(
            cameraController: _cameraController,
            submitPhotoBloc: _submitPhotoBloc,
          ),
        ),
      ),
    );
  }
}

class PreviewPhotoContent extends StatelessWidget {
  const PreviewPhotoContent({
    super.key,
    required CameraController? cameraController,
    required AttendanceSubmitPhotoBloc submitPhotoBloc,
  })  : _cameraController = cameraController,
        _submitPhotoBloc = submitPhotoBloc;

  final CameraController? _cameraController;
  final AttendanceSubmitPhotoBloc _submitPhotoBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        children: [
          const InfoLocationAttendance(),
          SizedBox(height: 16.h),
          _cameraController != null
              ? Expanded(
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: CameraPreview(_cameraController!),
                          );
                        },
                      ),
                      IgnorePointer(
                        child: ClipPath(
                          clipper: InvertedCircleClipper(),
                          child: Container(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 12.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF272A2A).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 16.h,
                          ),
                          child: const Text(
                            "Posisikan wajah Anda di dalam lingkaran",
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          SizedBox(height: 8.h),
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 72.r,
            onPressed: () {
              if (_cameraController != null) {
                _submitPhotoBloc.add(
                  AttendanceSubmitPhotoEvent.takePhoto(
                    cameraController: _cameraController!,
                  ),
                );
              }
            },
            icon: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width * 0.48,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
