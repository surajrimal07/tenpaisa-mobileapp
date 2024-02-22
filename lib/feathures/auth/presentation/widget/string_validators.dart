import 'package:paisa/core/utils/string_utils.dart';

mixin FieldValidator {
  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return ValidatorStrings.nameEmpty;
    }

    final nameRegex = RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$');
    if (!nameRegex.hasMatch(name)) {
      return ValidatorStrings.nameInvalid;
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ValidatorStrings.passwordEmpty;
    }

    if (password.length < 6) {
      return ValidatorStrings.passwordLength;
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ValidatorStrings.emailEmpty;
    }

    final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
    if (!emailRegex.hasMatch(email)) {
      return ValidatorStrings.emailInvalid;
    }

    return null;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return ValidatorStrings.phoneEmpty;
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(phone)) {
      return ValidatorStrings.phoneInvalid;
    }

    return null;
  }

  Map<String, String?> validateAllFields({
    String? name,
    String? password,
    String? email,
    String? phone,
  }) {
    final Map<String, String?> errors = {};

    errors['name'] = validateName(name);
    errors['password'] = validatePassword(password);
    errors['email'] = validateEmail(email);
    errors['phone'] = validatePhone(phone);

    return errors;
  }
}

// class FormFieldUtils {
//   static void emailEditingComplete(
//       TextEditingController controller, FocusScopeNode node) {
//     final String email = controller.text.trim();
//     final String? emailError = validateEmail(email);
//     if (emailError == null) {
//       node.nextFocus();
//     } else {
//       CustomToast.showToast(emailError);
//     }
//   }

//   static void passwordEditingComplete(
//       TextEditingController controller, FocusScopeNode node) {
//     final String password = controller.text.trim();
//     final validator = FieldValidator();
//     final String? passwordError = validator.validatePassword(password);
//     if (passwordError == null) {
//       // Call API or additional logic here
//       node.unfocus();
//     } else {
//       CustomToast.showToast(passwordError);
//     }
//   }
// }
