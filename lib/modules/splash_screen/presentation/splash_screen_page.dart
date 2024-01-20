import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/auto_route/auto_route.gr.dart';

@RoutePage()
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      AutoRouter.of(context)
          .pushAndPopUntil(const HomeRoute(), predicate: (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Attendance App"),
      ),
    );
  }
}
