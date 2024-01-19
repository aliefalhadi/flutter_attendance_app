import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocEventLogger extends BlocObserver {
  final String blocErrorLogTag = "Bloc-Error";
  final String blocEventLogTag = "Bloc-Event";

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    if (kDebugMode) {
      log('$event', name: 'onEvent(${bloc.runtimeType})');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('$change', name: 'onChange(${bloc.runtimeType})');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    String errorInfo = "$blocErrorLogTag from $bloc: $error";

    log(' $error, $stackTrace)', name: 'onError(${bloc.runtimeType})');
  }
}
