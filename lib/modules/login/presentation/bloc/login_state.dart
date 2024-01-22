part of 'login_bloc.dart';

enum LoginStatus { initial, loading, loaded, failure }

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(EmailValidator.pure()) EmailValidator email,
    @Default(PasswordValidator.pure()) PasswordValidator password,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus formStatus,
    @Default(false) bool isValid,
    @Default(LoginStatus.initial) LoginStatus status,
  }) = _LoginState;
}
