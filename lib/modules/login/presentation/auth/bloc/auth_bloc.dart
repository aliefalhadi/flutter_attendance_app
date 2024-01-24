import 'dart:async';

import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:attendance_app/modules/login/domain/usecases/delete_user_login_usecase.dart';
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
  final DeleteUserLoginUseCase _deleteUserLoginUseCase;

  AuthBloc(this._getUserLoginUseCase, this._deleteUserLoginUseCase)
      : super(const AuthState()) {
    on<_GetUserLogin>(_onGetUserLogin);
    on<_Logout>(_onLogout);
  }

  FutureOr<void> _onGetUserLogin(event, emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final res = await _getUserLoginUseCase();

    res.fold((l) => null, (user) {
      emit(state.copyWith(status: AuthStatus.loaded, userEntity: user));
    });
  }

  FutureOr<void> _onLogout(event, emit) async {
    await _deleteUserLoginUseCase();

    emit(
      state.copyWith(userEntity: null),
    );
  }
}
