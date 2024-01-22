import 'package:attendance_app/modules/login/presentation/auth/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context.read<AuthBloc>().add(const AuthEvent.getUserLogin());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, next) {
        return next.status == AuthStatus.loaded;
      },
      listener: (context, state) {
        if (state.userEntity == null) {
          AutoRouter.of(context)
              .pushAndPopUntil(const LoginRoute(), predicate: (route) => false);
        } else if (state.userEntity != null) {
          AutoRouter.of(context)
              .pushAndPopUntil(const HomeRoute(), predicate: (route) => false);
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text("Attendance App"),
        ),
      ),
    );
  }
}
