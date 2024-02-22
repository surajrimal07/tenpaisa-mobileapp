import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';

class SignOutDialog extends ConsumerWidget {

  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text(LogoutStrings.logoutText),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ref.read(authViewModelProvider.notifier).logout(ref);
          },
          child: const Text(DialogStrings.yes),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(DialogStrings.no),
        ),
      ],
    );
  }
}
