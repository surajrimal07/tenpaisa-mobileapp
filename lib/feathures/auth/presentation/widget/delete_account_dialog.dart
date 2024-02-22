import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';

class DeleteAccountDialog extends ConsumerWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = ref.watch(passwordControllerProvider);
    //final formKey = GlobalKey<FormState>();
    final formKey = ref.watch(formKeyProvider);

    String? passError;

    return AlertDialog(
      title: const Text(DeleteDialogStrings.deleteAccount),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(DeleteDialogStrings.enterPasswordText),
            SizedBox(height: Sizes.dynamicHeight(2)),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: DeleteDialogStrings.passwordLabel,
                errorText: passError,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return DeleteDialogStrings.passwordError;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              String pass = passwordController.text;
              ref.read(authViewModelProvider.notifier).deleteUser(pass, ref);
              // Navigator.of(context).pop();
              passwordController.clear();
            }
          },
          child: const Text(DeleteDialogStrings.delete),
        ),
        ElevatedButton(
          onPressed: () {
            passwordController.clear();
            Navigator.of(context).pop();
          },
          child: const Text(DeleteDialogStrings.cancel),
        ),
      ],
    );
  }
}
