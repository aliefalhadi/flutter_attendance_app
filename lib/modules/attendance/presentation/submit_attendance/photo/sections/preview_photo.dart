import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviewPhoto extends StatelessWidget {
  const PreviewPhoto({
    Key? key,
    required this.imagePath,
    required this.onClickSuccess,
    required this.onClickTryAgain,
  }) : super(key: key);

  final String imagePath;
  final VoidCallback onClickSuccess;
  final VoidCallback onClickTryAgain;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.h,
      ),
      width: 1.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(18),
              height: 4.h,
              width: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  60.r,
                ),
              ),
            ),
          ),
          const Text("Foto Absensi"),
          SizedBox(height: 12.h),
          Center(
            child: SizedBox(
              width: 248.r,
              height: 248.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(248.r),
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) => SizedBox(
                    width: 1.sw,
                    height: 100.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          StatusPhoto(
            onClickSuccess: onClickSuccess,
            onClickTryAgain: onClickTryAgain,
          ),
        ],
      ),
    );
  }
}

class StatusPhoto extends StatelessWidget {
  const StatusPhoto({
    Key? key,
    required this.onClickSuccess,
    required this.onClickTryAgain,
  }) : super(key: key);

  final VoidCallback onClickSuccess;
  final VoidCallback onClickTryAgain;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            "Foto ini akan digunakan untuk absen.",
          ),
        ),
        SizedBox(height: 32.h),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: onClickTryAgain,
                child: const Text("Foto Ulang"),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: onClickSuccess,
                child: const Text("Simpan"),
              ),
            )
          ],
        ),
      ],
    );
  }
}
