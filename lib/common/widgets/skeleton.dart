import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double? height, width;
  final bool isCircle;
  final double? radius;

  const Skeleton({
    Key? key,
    this.height,
    this.width,
    this.isCircle = false,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.black.withOpacity(0.08),
      baseColor: Colors.black.withOpacity(0.1),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              radius != null
                  ? radius!
                  : isCircle
                      ? 100.r
                      : 16.r,
            ),
          ),
        ),
      ),
    );
  }
}
