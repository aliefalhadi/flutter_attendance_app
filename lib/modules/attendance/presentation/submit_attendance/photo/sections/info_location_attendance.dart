import 'dart:async';

import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../common/widgets/skeleton.dart';
import '../bloc/attendance_submit_photo_bloc.dart';

class InfoLocationAttendance extends StatelessWidget {
  const InfoLocationAttendance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEF0F0)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: const Column(
        children: [
          DateTimeInfo(),
          AddressNameInfo(),
        ],
      ),
    );
  }
}

class AddressNameInfo extends StatelessWidget {
  const AddressNameInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceSubmitPhotoBloc, AttendanceSubmitPhotoState>(
      builder: (context, state) {
        if (state.placeAddressName?.isNotEmpty ?? false) {
          return Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text(
              state.placeAddressName!,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class DateTimeInfo extends StatefulWidget {
  const DateTimeInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<DateTimeInfo> createState() => _DateTimeInfoState();
}

class _DateTimeInfoState extends State<DateTimeInfo> {
  DateTime? dateTimeNow;
  Timer? timer;
  void getDateTime(DateTime dateTimeLocationNow) async {
    setState(() {
      dateTimeNow = dateTimeLocationNow;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        dateTimeNow = dateTimeNow!.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceSubmitPhotoBloc, AttendanceSubmitPhotoState>(
      listenWhen: (prev, next) {
        return prev.dateTimeNow != next.dateTimeNow;
      },
      listener: (context, state) {
        if (state.dateTimeNow != null) {
          getDateTime(state.dateTimeNow!);
        }
      },
      child: BlocBuilder<AttendanceSubmitPhotoBloc, AttendanceSubmitPhotoState>(
        builder: (context, state) {
          if (state.dateTimeNow == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Skeleton(width: 100.w),
                Skeleton(width: 100.w),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateTimeNow!.toFormatDayIndonesian(),
              ),
              Text(
                dateTimeNow!.toFormatTime(),
              ),
            ],
          );
        },
      ),
    );
  }
}
