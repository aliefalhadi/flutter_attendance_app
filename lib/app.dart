import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/auto_route/auto_route.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 720),
      minTextAdapt: false,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Attendance App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget!,
            );
          },
          // theme: AppTheme.theme,
          routerDelegate: AutoRouterDelegate(
            _appRouter,
          ),
          // scaffoldMessengerKey: Alert.snackbarKey,
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
