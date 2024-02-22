import 'package:flutter/material.dart';
import 'package:paisa/core/utils/string_utils.dart';

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(DashboardStrings.youSure),
          content: const Text(DashboardStrings.exitApp),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(DashboardStrings.yes),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(DashboardStrings.no),
            ),
          ],
        ),
      ) ??
      false;
}
