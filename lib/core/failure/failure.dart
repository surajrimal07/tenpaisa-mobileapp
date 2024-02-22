import 'package:paisa/core/common/toast/app_toast.dart';

class Failure {
  final String error;
  final String? statusCode;
  final bool showToast;

  Failure({required this.error, this.statusCode, this.showToast = true}) {
    if (showToast) {
      CustomToast.showToast(error.toString(), customType: Type.error);
    }
  }
}
