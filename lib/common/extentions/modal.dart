import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BuildContextX on BuildContext {
  Future showBottomSheetModal({
    required Widget child,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet(
      context: this,
      enableDrag: false,
      isDismissible: isDismissible,
      useRootNavigator: true,
      routeSettings: const RouteSettings(name: 'modal-pin'),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) => child,
    );
  }
}
