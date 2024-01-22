import 'package:attendance_app/common/auto_route/auto_route.gr.dart';
import 'package:attendance_app/modules/login/presentation/auth/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Text(state.userEntity!.name ?? '');
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: SizedBox(
          width: 1.sw,
          child: ElevatedButton(
            child: const Text("Absen Masuk"),
            onPressed: () {
              AutoRouter.of(context).push(
                LocationSubmitAttendanceRoute(isClockIn: true),
              );
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          const _Header(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "REKAP ABSEN",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextButton(
                        onPressed: () {}, child: const Text("Lihat Semua"))
                  ],
                ),
                const Divider(),
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(vertical: 56.h, horizontal: 16.w),
                //   child: Column(
                //     children: [
                //       Text(
                //         "Tidak ada rekap absen",
                //         style: Theme.of(context)
                //             .textTheme
                //             .titleLarge!
                //             .copyWith(fontWeight: FontWeight.w600),
                //       ),
                //       SizedBox(height: 8.h),
                //       Text(
                //           "Rekap absen Anda akan tampil disini ketika Anda sudah melakukan absen",
                //           textAlign: TextAlign.center,
                //           style: Theme.of(context).textTheme.titleSmall!),
                //     ],
                //   ),
                // )
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0x00000000).withOpacity(0.43),
                                offset: const Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: -1,
                              )
                            ]),
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
                                  "Absen Masuk",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.h),
                                Text("April 20, 2023",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Absen Masuk",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.h),
                                Text("April 20, 2023",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0x00000000).withOpacity(0.43),
                                offset: const Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: -1,
                              )
                            ]),
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
                                  "Absen Masuk",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.h),
                                Text("April 20, 2023",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Absen Masuk",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.h),
                                Text("April 20, 2023",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          const Text("Senin, 25 Januari 2023"),
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
          Container(
            decoration: BoxDecoration(
                color: Color(0xffFCE9EA),
                borderRadius: BorderRadius.circular(16.r)),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: Text("Belum Absen"),
          )
        ],
      ),
    );
  }
}
