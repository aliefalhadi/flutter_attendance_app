import 'package:flutter/material.dart';

class Alert {
  const Alert._();

  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  static final BuildContext context = snackbarKey.currentContext!;

  static void showSnackBar(
    String message, {
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    bool isError = false,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
    String? actionLabel,
    VoidCallback? actionOnPressed,
  }) {
    snackbarKey.currentState?.clearSnackBars();

    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.black,
        behavior: behavior,
        duration: duration,
        content: Text(
          message,
        ),
        action: (actionLabel != null && actionOnPressed != null)
            ? SnackBarAction(
                textColor: Colors.white,
                label: actionLabel,
                onPressed: actionOnPressed,
              )
            : null,
      ),
    );
  }
}
