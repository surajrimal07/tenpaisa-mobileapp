import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/utils/string_utils.dart';

final rememberMeProvider = StateProvider.autoDispose<bool>((ref) => false);
final obscureTextProvider = StateProvider.autoDispose<bool>((ref) => true);

final emailControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(text: InputControllersStrings.email),
);

final otpControllerProvider = StateProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final passwordControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(text: InputControllersStrings.password),
);
final phoneControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(text: InputControllersStrings.phone),
);
final nameControllerProvider = StateProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(text: InputControllersStrings.name),
);

final othersControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final searchControllerProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final priceControllerProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final quantityControllerProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final formKeyProvider = Provider.autoDispose((_) => GlobalKey<FormState>());

final scrollControllerProvider =
    Provider.autoDispose((_) => ScrollController());
