import 'dart:async';
import 'dart:io';

import 'package:attendance_app/common/auto_route/auto_route.gr.dart';
import 'package:attendance_app/common/di_module/init_config.dart';
import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../../../../../common/widgets/skeleton.dart';
import 'bloc/attendance_submit_location_bloc.dart';

@RoutePage()
class LocationSubmitAttendancePage extends StatefulWidget {
  const LocationSubmitAttendancePage({
    super.key,
    required this.isClockIn,
  });

  final bool isClockIn;

  @override
  State<LocationSubmitAttendancePage> createState() =>
      _LocationSubmitAttendancePageState();
}

class _LocationSubmitAttendancePageState
    extends State<LocationSubmitAttendancePage> {
  late DateTime dateTimeNow;
  MapController? mapController;
  LocationPermission? permission;
  late AttendanceSubmitLocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = getIt<AttendanceSubmitLocationBloc>();

    mapController = MapController(
      initMapWithUserPosition: true,
    );
    dateTimeNow = DateTime.now();

    _determinePosition().then((value) async {
      if (value) {
        _locationBloc.add(
          const AttendanceSubmitLocationEvent.getLocation(),
        );
      }
    });
  }

  @override
  void dispose() {
    mapController?.dispose();

    super.dispose();
  }

  Future<bool> _determinePosition() async {
    Location location = Location();
    bool serviceGpsEnabled = await location.serviceEnabled();
    if (!serviceGpsEnabled) {
      serviceGpsEnabled = await location.requestService();
      if (!serviceGpsEnabled) {
        Navigator.pop(context);

        return false;
      }
    }

    permission = await Geolocator.checkPermission();
    if (isLocationDenied()) {
      permission = await Geolocator.requestPermission();
      if (isLocationDenied()) {
        Navigator.pop(context);
        return false;
      }
    }

    return true;
  }

  bool isLocationDenied() {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _locationBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.isClockIn ? "Absen Masuk" : "Absen Keluar"} • Geolokasi',
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          child: SizedBox(
            width: 1.sw,
            child: BlocBuilder<AttendanceSubmitLocationBloc,
                AttendanceSubmitLocationState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed:
                      state.status == AttendanceSubmitLocationStatus.loaded
                          ? () {
                              AutoRouter.of(context).push(
                                AttendanceSubmitPhotoRoute(
                                  isClockIn: true,
                                  latLngLocation:
                                      _locationBloc.state.coordinateLocation!,
                                  placeAddressName: _locationBloc
                                      .state.placeSearchEntity!.placeAddress,
                                ),
                              );
                            }
                          : null,
                  child: const Text("Ambil Foto"),
                );
              },
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              BuildDateTimeHeader(
                dateTimeNow: dateTimeNow,
              ),
              SizedBox(height: 16.h),
              const Text("Lokasi Anda:"),
              SizedBox(height: 4.h),
              const BuildAddressLocation(),
              SizedBox(height: 32.h),
              MapContent(
                mapController: mapController!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildDateTimeHeader extends StatelessWidget {
  const BuildDateTimeHeader({Key? key, required this.dateTimeNow})
      : super(key: key);

  final DateTime dateTimeNow;

  @override
  Widget build(BuildContext context) {
    return DateTimeHeader(
      dateTimeNow: dateTimeNow,
    );
  }
}

class DateTimeHeader extends StatefulWidget {
  const DateTimeHeader({Key? key, required this.dateTimeNow}) : super(key: key);

  final DateTime dateTimeNow;

  @override
  State<DateTimeHeader> createState() => _DateTimeHeaderState();
}

class _DateTimeHeaderState extends State<DateTimeHeader> {
  late DateTime dateTimeNow;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    dateTimeNow = widget.dateTimeNow;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        dateTimeNow = dateTimeNow.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dateTimeNow.toFormatDayIndonesian(),
        ),
        SizedBox(height: 8.h),
        Text(
          dateTimeNow.toFormatTime(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class BuildAddressLocation extends StatelessWidget {
  const BuildAddressLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceSubmitLocationBloc,
        AttendanceSubmitLocationState>(builder: (context, state) {
      if (state.status == AttendanceSubmitLocationStatus.loaded) {
        return Text(
          state.placeSearchEntity!.placeAddress,
          textAlign: TextAlign.center,
        );
      }

      return Skeleton(
        width: 200.w,
      );
    });
  }
}

class MapContent extends StatelessWidget {
  const MapContent({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceSubmitLocationBloc,
        AttendanceSubmitLocationState>(
      builder: (context, state) {
        if (state.status == AttendanceSubmitLocationStatus.loaded &&
            state.coordinateLocation != null) {
          return SizedBox(
            width: 1.sw,
            height: 200.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: OSMFlutter(
                controller: mapController,
                trackMyPosition: false,
                initZoom: 16,
                minZoomLevel: 16,
                maxZoomLevel: 16,
                showZoomController: false,
                onMapIsReady: (value) {
                  mapController.goToLocation(state.coordinateLocation!);

                  mapController.addMarker(
                    state.coordinateLocation!,
                    markerIcon: MarkerIcon(
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: Platform.isAndroid ? 100 : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return Skeleton(
          width: 1.sw,
          height: 200.h,
        );
      },
    );
  }
}
