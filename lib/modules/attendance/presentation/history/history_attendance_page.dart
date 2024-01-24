import 'package:attendance_app/common/di_module/init_config.dart';
import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:attendance_app/modules/attendance/presentation/history/bloc/history_attendance_bloc.dart';
import 'package:attendance_app/modules/login/presentation/auth/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/auto_route/auto_route.gr.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/widgets/skeleton.dart';
import '../../domain/entities/attendance_entity.codegen.dart';

part 'sections/history_attendance.dart';
part 'sections/selected_date.dart';

@RoutePage()
class HistoryAttendancePage extends StatefulWidget {
  const HistoryAttendancePage({super.key});

  @override
  State<HistoryAttendancePage> createState() => _HistoryAttendancePageState();
}

class _HistoryAttendancePageState extends State<HistoryAttendancePage> {
  late HistoryAttendanceBloc _historyAttendanceBloc;

  @override
  void initState() {
    super.initState();
    _historyAttendanceBloc = getIt<HistoryAttendanceBloc>();
    _historyAttendanceBloc.add(
      HistoryAttendanceEvent.initDate(
        userEntity: context.read<AuthBloc>().state.userEntity!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _historyAttendanceBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Riwayat Absensi',
          ),
        ),
        body: ListView(
          children: const [_SelectedDate(), _HistoryAttendance()],
        ),
      ),
    );
  }
}
