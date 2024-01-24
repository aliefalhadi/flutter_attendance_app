import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../login/presentation/auth/bloc/auth_bloc.dart';

class BottomSheetLogout extends StatelessWidget {
  const BottomSheetLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keluar Akun',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.h),
                const Text(
                  'Anda akan keluar dari akun. Lanjutkan?',
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    child: const Text("Tutup"),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEvent.logout());
                    },
                    child: const Text("Lanjutkan"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
