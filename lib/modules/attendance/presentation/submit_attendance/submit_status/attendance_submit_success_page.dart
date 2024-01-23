import 'package:attendance_app/common/auto_route/auto_route.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class AttendanceSubmitSuccessPage extends StatelessWidget {
  const AttendanceSubmitSuccessPage({
    Key? key,
    required this.dateTimeAttendance,
    this.locationAttendance,
    required this.isClockIn,
  }) : super(key: key);

  final String dateTimeAttendance;
  final String? locationAttendance;
  final bool isClockIn;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        AutoRouter.of(context).pushAndPopUntil(
          const HomeRoute(),
          predicate: (route) => false,
        );
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isClockIn
                      ? 'Absen Masuk Berhasil!'
                      : 'Absen Keluar Berhasil!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 24.h),
                InfoTile(
                  icon: const Icon(Icons.access_time),
                  title: dateTimeAttendance,
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.h),
                  child: InfoTile(
                    icon: const Icon(Icons.location_on),
                    title: locationAttendance!,
                  ),
                ),
                SizedBox(height: 56.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("Tutup"),
                    onPressed: () {
                      AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
                          predicate: (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
