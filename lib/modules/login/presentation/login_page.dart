import 'package:attendance_app/common/di_module/init_config.dart';
import 'package:attendance_app/common/util/dialog_helper.dart';
import 'package:attendance_app/modules/login/presentation/auth/bloc/auth_bloc.dart';
import 'package:attendance_app/modules/login/presentation/bloc/login_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/auto_route/auto_route.gr.dart';
import '../../../common/widgets/alert.dart';
import '../../../common/widgets/text_form_widget.dart';

part 'sections/form_login_section.dart';
part 'sections/header_section.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listenWhen: (prev, next) {
              return prev.status != next.status;
            },
            listener: (context, state) {
              if (state.status == LoginStatus.loading) {
                DialogHelper.showLoadingDialog(context);
              } else if (state.status == LoginStatus.loaded) {
                context.read<AuthBloc>().add(const AuthEvent.getUserLogin());
              } else if (state.status == LoginStatus.failure) {
                Navigator.pop(context);
                Alert.showSnackBar("Email / Password salah");
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (prev, next) {
              return next.status == AuthStatus.loaded;
            },
            listener: (context, state) {
              if (state.userEntity != null) {
                AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
                    predicate: (route) => false);
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: const Column(
            children: [
              Expanded(
                flex: 1,
                child: _HeaderSection(),
              ),
              Expanded(
                flex: 2,
                child: _FormLoginSection(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
