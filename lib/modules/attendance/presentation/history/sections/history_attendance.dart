part of '../history_attendance_page.dart';

class _HistoryAttendance extends StatelessWidget {
  const _HistoryAttendance();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DAFTAR ABSENSI",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const Divider(),
          BlocBuilder<HistoryAttendanceBloc, HistoryAttendanceState>(
            builder: (context, state) {
              if (state.status == HistoryAttendanceStatus.loaded &&
                  state.listAttendance.isNotEmpty) {
                return _ListHistoryAttendance(state.listAttendance);
              } else if (state.status == HistoryAttendanceStatus.loaded) {
                return const _EmptyAttendance();
              } else {
                return Column(
                  children: [
                    Skeleton(width: 1.sw, height: 80.h),
                    SizedBox(height: 8.h),
                    Skeleton(width: 1.sw, height: 80.h),
                    SizedBox(height: 8.h),
                    Skeleton(width: 1.sw, height: 80.h),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class _EmptyAttendance extends StatelessWidget {
  const _EmptyAttendance();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100.h),
      child: Column(
        children: [
          Text(
            "Tidak ada riwayat absen",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 8.h,
          ),
          const Text(
            "Belum ada absensi untuk saat ini, seluruh absensi dapat dilihat di halaman ini",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ListHistoryAttendance extends StatelessWidget {
  const _ListHistoryAttendance(this.listAttendance);

  final List<AttendanceEntity> listAttendance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listAttendance.length,
        itemBuilder: (context, index) {
          final attendance = listAttendance[index];

          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x00000000).withOpacity(0.43),
                  offset: const Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: -1,
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(
                    Icons.login,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attendance.type == 'clockin'
                          ? "Absen Masuk"
                          : "Absen Keluar",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(attendance.toAttendanceTime().formatTimeAndZone(),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      attendance.toAttendanceTime().toFormatShift(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(attendance.isLate == 1 ? "Late" : "On Time",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
