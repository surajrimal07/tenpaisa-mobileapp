import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValidationResult {
  final bool isValid;

  ValidationResult(this.isValid);
}

class ValidationNotifier extends Notifier<ValidationResult> {
  ValidationNotifier(ValidationResult? value) : super();

  void validateEmail(String email) {
    state = _isValidEmail(email);
  }

  void validatePhone(String phone) {
    state = _isValidPhone(phone);
  }

  void validatePassword(String password) {
    state = _isValidPassword(password);
  }

  void validateName(String name) {
    state = _isValidName(name);
  }

  void validateText(String text) {
    state = _isValidText(text);
  }

  ValidationResult _isValidEmail(String email) {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0.9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return ValidationResult(emailRegExp.hasMatch(email));
  }

  ValidationResult _isValidPhone(String phone) {
    final phoneRegExp = RegExp(r"^\d{10}$");
    return ValidationResult(phoneRegExp.hasMatch(phone));
  }

  ValidationResult _isValidPassword(String password) {
    return ValidationResult(password.length >= 5);
  }

  ValidationResult _isValidName(String name) {
    final nameRegExp = RegExp(r"^[a-zA-Z]+ [a-zA-Z]+$");
    return ValidationResult(nameRegExp.hasMatch(name));
  }

  ValidationResult _isValidText(String text) {
    return ValidationResult(text.isNotEmpty);
  }

  @override
  ValidationResult build() {
    return state;
  }
}

final validationProvider = Provider<ValidationNotifier>((ref) {
  return ValidationNotifier(ValidationResult(true));
});





//**************************************** */
//example usage
// final validationProvider = NotifierProvider<ValidationNotifier, bool>((ref) {
//   return ValidationNotifier(true);
// });

// final validationState = ref.watch(validationProvider);

// // Example of validating an email
// ref.read(validationProvider.notifier).validateEmail('test@example.com');

// // Example of checking the validation state
// if (validationState) {
//   // Field is valid
// } else {
//   // Field is not valid
// }