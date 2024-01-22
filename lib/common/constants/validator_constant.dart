import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class PasswordValidator extends FormzInput<String, PasswordValidationError> {
  const PasswordValidator.pure() : super.pure('');
  const PasswordValidator.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    return null;
  }
}

enum EmailValidationError { empty }

class EmailValidator extends FormzInput<String, EmailValidationError> {
  const EmailValidator.pure() : super.pure('');
  const EmailValidator.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    return null;
  }
}
