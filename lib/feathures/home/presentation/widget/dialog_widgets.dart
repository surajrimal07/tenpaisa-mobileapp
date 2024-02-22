import 'package:flutter/material.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Widgets {
  Future<void> showSignOutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(DialogStrings.signOutTitle),
          actions: [
            TextButton(
              onPressed: () async {
                if (!context.mounted) {
                  return;
                }

                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('userToken');
                CustomToast.showToast(DialogStrings.loggingOut);

                if (context.mounted) {
                  Navigator.of(context).pop();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoute.authRoute,
                    (route) => false,
                  );
                }
              },
              child: const Text(DialogStrings.yes),
            ),
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  CustomToast.showToast(DialogStrings.loggedOutError);
                }
              },
              child: const Text(DialogStrings.no),
            ),
          ],
        );
      },
    );
  }
}
