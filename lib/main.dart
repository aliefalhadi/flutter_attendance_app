import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'common/config/app_config.dart';
import 'common/di_module/init_config.dart';
import 'common/loggers/bloc_event_logger.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  await configureDependencies();

  await AppConfig.initialize();

  Bloc.observer = BlocEventLogger();

  runApp(App());
}
