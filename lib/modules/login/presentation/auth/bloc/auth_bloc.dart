import 'dart:async';

import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_user_login_usecase.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserLoginUseCase _getUserLoginUseCase;

  AuthBloc(this._getUserLoginUseCase) : super(const AuthState()) {
    on<_GetUserLogin>(_onGetUserLogin);
  }

  FutureOr<void> _onGetUserLogin(event, emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final res = await _getUserLoginUseCase();

    res.fold((l) => null, (user) {
      emit(state.copyWith(status: AuthStatus.loaded, userEntity: user));
    });
  }
}
