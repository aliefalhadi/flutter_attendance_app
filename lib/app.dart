import 'package:attendance_app/common/di_module/init_config.dart';
import 'package:attendance_app/modules/login/presentation/auth/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/auto_route/auto_route.dart';
import 'common/widgets/alert.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: ScreenUtilInit(
        designSize: const Size(360, 720),
        minTextAdapt: false,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Attendance App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: false,
              fontFamily: "Inter",
              appBarTheme: const AppBarTheme(
                elevation: 0,
                centerTitle: false,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              ),
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
            scaffoldMessengerKey: Alert.snackbarKey,
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
