import 'package:flutter/foundation.dart';

@immutable
final class StringConstant {
  const StringConstant._();

  static const String usernameHint = 'Username';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String loginText = 'Login';
  static const String registerText = 'Register';

  static const usernameFieldRequiredText = 'Username field required.';
  static const emailFieldRequiredText = 'Email field required.';
  static const passwordFieldRequiredText = 'Password field required.';
  static const emailIncorrectErrorText = 'Incorrect email format!';

  static const generalErrorText = 'Something went wrong.';
}
