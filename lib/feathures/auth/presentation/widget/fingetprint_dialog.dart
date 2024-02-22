import 'package:flutter/material.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/core/utils/string_utils.dart';

class BiometricsAlertDialog extends StatefulWidget {
  final UserSharedPrefs userSharedPrefs;

  const BiometricsAlertDialog({super.key, required this.userSharedPrefs});

  @override
  BiometricsAlertDialogState createState() => BiometricsAlertDialogState();
}

class BiometricsAlertDialogState extends State<BiometricsAlertDialog> {
  late bool useFingerprint = false;

  @override
  void initState() {
    super.initState();
    initUseFingerprint();
  }

  Future<void> initUseFingerprint() async {
    useFingerprint = await widget.userSharedPrefs.getUseFingerprint();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(FingerprintDialogStrings.biometricsTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(FingerprintDialogStrings.enableFingerprint),
            trailing: Switch(
              value: useFingerprint,
              onChanged: (value) {
                setState(() {
                  useFingerprint = value;
                });
                if (value) {
                  widget.userSharedPrefs.setUseFingerprint();
                } else {
                  widget.userSharedPrefs.remUseFingerprint();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
