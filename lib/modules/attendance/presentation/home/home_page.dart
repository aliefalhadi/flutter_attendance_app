import 'package:attendance_app/common/auto_route/auto_route.gr.dart';
import 'package:attendance_app/common/constants/app_colors.dart';
import 'package:attendance_app/common/di_module/init_config.dart';
import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:attendance_app/common/widgets/skeleton.dart';
import 'package:attendance_app/modules/attendance/presentation/home/bloc/attendance_home_bloc.dart';
import 'package:attendance_app/modules/login/presentation/auth/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/attendance_entity.codegen.dart';

part 'sections/header.dart';
part 'sections/history_attendance.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AttendanceHomeBloc attendanceHomeBloc;

  @override
  void initState() {
    super.initState();

    attendanceHomeBloc = getIt<AttendanceHomeBloc>();

    attendanceHomeBloc.add(AttendanceHomeEvent.getListAttendanceToday(
        userEntity: context.read<AuthBloc>().state.userEntity!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => attendanceHomeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Text(state.userEntity!.name ?? '');
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
          ],
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          child: SizedBox(
            width: 1.sw,
            child: BlocBuilder<AttendanceHomeBloc, AttendanceHomeState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.status == AttendanceHomeStatus.loaded
                      ? () {
                          AutoRouter.of(context).push(
                            LocationSubmitAttendanceRoute(
                                isClockIn: state.isClockIn()),
                          );
                        }
                      : null,
                  child: Text(
                    (state.isClockIn()) ? "Absen Masuk" : "Absen Keluar",
                  ),
                );
              },
            ),
          ),
        ),
        body: ListView(
          children: const [_Header(), _HistoryAttendance()],
        ),
      ),
    );
  }
}
