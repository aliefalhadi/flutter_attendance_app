import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogHelper {
  const DialogHelper._();

  static Future<void> showLoadingDialog(
    BuildContext context, {
    bool popped = true,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return PopScope(
          canPop: popped,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(10).r),
                color: Colors.white,
              ),
              width: 100.r,
              height: 100.r,
              padding: const EdgeInsets.all(16).r,
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
