import 'dart:io';

import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:attendance_app/modules/attendance/domain/entities/attendance_entity.codegen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class AttendanceDetailPage extends StatelessWidget {
  const AttendanceDetailPage({
    Key? key,
    required this.attendanceEntity,
  }) : super(key: key);

  final AttendanceEntity attendanceEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Absen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            AttendanceDetailTile(
              title: "Tipe Absen",
              child: Text(
                attendanceEntity.isTypeClockIn()
                    ? "Absen Masuk"
                    : "Absen Keluar",
              ),
            ),
            SizedBox(height: 20.h),
            AttendanceDetailTile(
              title: "Waktu Absen",
              child: Text(
                attendanceEntity.toAttendanceTime().toFormatDateAndTime(
                      format: 'dd MMMM yyyy HH:mm:ss',
                    ),
              ),
            ),
            SizedBox(height: 20.h),
            AttendanceDetailTile(
              title: attendanceEntity.isTypeClockIn()
                  ? "Jadwal Masuk"
                  : "Jadwal Keluar",
              child: Text(
                attendanceEntity.isTypeClockIn() ? "08:00" : "17:00",
              ),
            ),
            LocationAttendanceInfo(
              attendanceEntity: attendanceEntity,
            ),
            SizedBox(height: 20.h),
            AttendanceDetailTile(
              title: "Foto Absen",
              child: Center(
                child: SizedBox(
                  width: 248.r,
                  height: 248.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(248.r),
                    child: Image.network(
                      attendanceEntity.urlFaceLog!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationAttendanceInfo extends StatelessWidget {
  const LocationAttendanceInfo({
    Key? key,
    required this.attendanceEntity,
  }) : super(key: key);

  final AttendanceEntity attendanceEntity;

  @override
  Widget build(BuildContext context) {
    GeoPoint latLngAttendance = GeoPoint(
      latitude: attendanceEntity.latitude!,
      longitude: attendanceEntity.longitude!,
    );

    MapController controller = MapController(
      initMapWithUserPosition: false,
      initPosition: latLngAttendance,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.h),
          child: AttendanceDetailTile(
            title: "Lokasi Absen",
            child: Text(
              attendanceEntity.location ?? '',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          child: AttendanceDetailTile(
            title: "Geo Lokasi",
            child: SizedBox(
              width: 1.sw,
              height: 200.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: OSMFlutter(
                  controller: controller,
                  trackMyPosition: false,
                  initZoom: 16,
                  minZoomLevel: 16,
                  maxZoomLevel: 16,
                  onMapIsReady: (value) {
                    controller.addMarker(
                      latLngAttendance,
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
            ),
          ),
        ),
      ],
    );
  }
}

class AttendanceDetailTile extends StatelessWidget {
  const AttendanceDetailTile({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
}
