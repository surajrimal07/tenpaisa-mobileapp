import 'package:flutter/material.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';

class ShakeLogoutDialog extends StatefulWidget {
  final UserSharedPrefs userSharedPrefs;

  const ShakeLogoutDialog({super.key, required this.userSharedPrefs});

  @override
  ShakeLogoutDialogState createState() => ShakeLogoutDialogState();
}

class ShakeLogoutDialogState extends State<ShakeLogoutDialog> {
  late bool shakeEnabled = false;

  @override
  void initState() {
    super.initState();
    initIsShake();
  }

  Future<void> initIsShake() async {
    shakeEnabled = await widget.userSharedPrefs.isShakeEnabled(null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Shake to Logout"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Enable Skake to Logout"),
            trailing: Switch(
              value: shakeEnabled,
              onChanged: (value) {
                setState(() {
                  shakeEnabled = value;
                });
                if (value) {
                  widget.userSharedPrefs.isShakeEnabled("true");
                } else {
                  widget.userSharedPrefs.isShakeEnabled("false");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
