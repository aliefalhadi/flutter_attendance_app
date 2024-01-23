part of '../home_page.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          BlocBuilder<AttendanceHomeBloc, AttendanceHomeState>(
            builder: (context, state) {
              if (state.status == AttendanceHomeStatus.loaded) {
                return Text(state.dateTimeNow!.toFormatDayIndonesian());
              }
              return SizedBox(width: 100.w);
            },
          ),
          SizedBox(height: 8.h),
          Text(
            "Jadwal Hari Ini",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: 4.h),
          Text(
            "08:00 - 13:00",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 8.h),
          BlocBuilder<AttendanceHomeBloc, AttendanceHomeState>(
            builder: (context, state) {
              if (state.status == AttendanceHomeStatus.loaded) {
                return _StatusAttendance(
                  listAttendance: state.listAttendance,
                );
              }
              return SizedBox(width: 100.w);
            },
          )
        ],
      ),
    );
  }
}

class _StatusAttendance extends StatelessWidget {
  const _StatusAttendance({
    required this.listAttendance,
  });

  final List<AttendanceEntity> listAttendance;

  @override
  Widget build(BuildContext context) {
    String status = "";
    if (listAttendance.isEmpty) {
      status = "Belum Absen";
    } else if (listAttendance.length % 2 != 0) {
      status = "Sudah Absen Masuk";
    } else {
      status = "Sudah Absen Keluar";
    }

    return Container(
      decoration: BoxDecoration(
        color:
            listAttendance.isEmpty ? AppColors.lightRed : AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
