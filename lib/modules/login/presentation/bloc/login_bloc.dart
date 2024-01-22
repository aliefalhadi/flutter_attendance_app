import 'dart:async';

import 'package:attendance_app/common/constants/validator_constant.dart';
import 'package:attendance_app/modules/login/domain/entity/login_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/post_login_usecase.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_Login>(_onLogin);
  }

  FutureOr<void> _onEmailChanged(_EmailChanged event, emit) {
    final email = EmailValidator.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(_PasswordChanged event, emit) {
    final password = PasswordValidator.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  FutureOr<void> _onLogin(_Login event, emit) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );

    final res = await _loginUseCase(
        LoginEntity(email: state.email.value, password: state.password.value));
    res.fold(
        (l) => emit(
              state.copyWith(status: LoginStatus.failure),
            ), (r) {
      emit(
        state.copyWith(status: LoginStatus.loaded),
      );
    });
  }
}
