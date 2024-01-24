import 'package:auto_route/auto_route.dart';

import 'auto_route.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashScreenRoute.page, path: '/'),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: LocationSubmitAttendanceRoute.page),
    AutoRoute(page: AttendanceSubmitPhotoRoute.page),
    AutoRoute(page: AttendanceSubmitSuccessRoute.page),
    AutoRoute(page: AttendanceSubmitErrorRoute.page),
    AutoRoute(page: HistoryAttendanceRoute.page),
    AutoRoute(page: AttendanceDetailRoute.page),
  ];
}
