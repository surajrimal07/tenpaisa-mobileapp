import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';

class ChangeThemeDialog extends ConsumerWidget {
  const ChangeThemeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(appThemeStateProvider);

    return AlertDialog(
      title: const Text(ThemeStrings.changeTheme),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: const Text(ThemeStrings.light),
            value: ThemeMode.light,
            groupValue: themeState.themeMode,
            onChanged: (value) {
              themeState.setLightTheme();
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text(ThemeStrings.dark),
            value: ThemeMode.dark,
            groupValue: themeState.themeMode,
            onChanged: (value) {
              themeState.setDarkTheme();
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text(ThemeStrings.system),
            value: ThemeMode.system,
            groupValue: themeState.themeMode,
            onChanged: (value) {
              themeState.setSystemTheme();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
