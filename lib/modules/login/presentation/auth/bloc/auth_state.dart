part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, loaded, failure }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserEntity? userEntity,
    @Default(AuthStatus.initial) AuthStatus status,
  }) = _AuthState;
}
