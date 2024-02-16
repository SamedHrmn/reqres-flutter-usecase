import 'package:reqres_flutter_case/utilities/form_extension.dart';
import 'package:reqres_flutter_case/utilities/string_constant.dart';

String? emailFormValidator(String? p0) {
  if (p0?.isEmpty ?? true) {
    return StringConstant.emailFieldRequiredText;
  } else if (p0?.isValidEmail() == false) {
    return StringConstant.emailIncorrectErrorText;
  }
  return null;
}

String? passwordFormValidator(String? p0) {
  if (p0?.isEmpty ?? true) {
    return StringConstant.passwordFieldRequiredText;
  }

  return null;
}

String? usernameFormValidator(String? p0) {
  if (p0?.isEmpty ?? true) {
    return StringConstant.usernameFieldRequiredText;
  }

  return null;
}
