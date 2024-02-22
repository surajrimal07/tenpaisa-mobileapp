import 'package:flutter/material.dart';

class AlertService {
  static void showAlert({
    required String title,
    required String textone,
    required String texttwo,
    required String body,
    required VoidCallback onCancel,
    required VoidCallback onOk,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: onOk,
            child: Text(textone),
          ),
          TextButton(
            onPressed: onCancel,
            child: Text(texttwo),
          ),
        ],
      ),
    );
  }
}
