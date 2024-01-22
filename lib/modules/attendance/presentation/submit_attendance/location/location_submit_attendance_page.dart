import 'dart:async';
import 'dart:io';

import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initMapWithUserPosition: true,
    );
    dateTimeNow = DateTime.now();
  }

  @override
  void dispose() {
    mapController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.isClockIn ? "Absen Masuk" : "Absen Keluar"} • Geolokasi',
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: SizedBox(
          width: 1.sw,
          child: ElevatedButton(
            child: const Text("Ambil Foto"),
            onPressed: () {},
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
    // return BlocBuilder<AttendanceSubmitLocationBloc,
    //     AttendanceSubmitLocationState>(builder: (context, state) {
    //   if (state.status == AttendanceSubmitLocationStatus.loaded) {
    //     return Text(
    //       state.placeSearchEntity!.placeAddress,
    //       style: AppTextStyle.f11TextW400Spacing03,
    //       textAlign: TextAlign.center,
    //     );
    //   }
    //
    //   return Skeleton(
    //     width: DimensionConstant.pixel200.w,
    //   );
    // });
    return Text(
      "Jl. Mandor Naiman 13, RT01/RW02, Jakarta Selatan, DKI Jakarta",
      textAlign: TextAlign.center,
    );
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
    // return BlocBuilder<AttendanceSubmitLocationBloc,
    //     AttendanceSubmitLocationState>(
    //   builder: (context, state) {
    //     if (state.status == AttendanceSubmitLocationStatus.loaded &&
    //         state.coordinateLocation != null) {
    //       return SizedBox(
    //         width: DimensionConstant.pixelFullWidth,
    //         height: 200.h,
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(8.r),
    //           child: OSMFlutter(
    //             controller: mapController,
    //             trackMyPosition: false,
    //             initZoom: 16,
    //             minZoomLevel: 16,
    //             maxZoomLevel: 16,
    //             showZoomController: false,
    //             onMapIsReady: (value) {
    //               mapController.goToLocation(state.coordinateLocation!);
    //
    //               mapController.addMarker(
    //                 state.coordinateLocation!,
    //                 markerIcon: MarkerIcon(
    //                   icon: Icon(
    //                     Icons.location_pin,
    //                     color: Colors.red,
    //                     size: Platform.isAndroid ? 100 : null,
    //                   ),
    //                 ),
    //               );
    //
    //               if (state.isRadiusOn()) {
    //                 mapController.drawCircle(CircleOSM(
    //                   key: "circleScopeAttendance",
    //                   centerPoint: GeoPoint(
    //                     longitude:
    //                     state.radiusAttendanceEntity!.outletLongitude!,
    //                     latitude: state.radiusAttendanceEntity!.outletLatitude!,
    //                   ),
    //                   radius:
    //                   state.radiusAttendanceEntity!.outletRadius.toDouble(),
    //                   color: AppColors.primary,
    //                   strokeWidth: 0.3,
    //                 ));
    //               }
    //             },
    //           ),
    //         ),
    //       );
    //     }
    //
    //     return Skeleton(
    //       width: DimensionConstant.pixelFullWidth,
    //       height: DimensionConstant.pixel200.h,
    //     );
    //   },
    // );

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
            mapController.goToLocation(
                GeoPoint(latitude: -7.8910283, longitude: 112.6679993));

            mapController.addMarker(
              GeoPoint(latitude: -7.8910283, longitude: 112.6679993),
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
}
