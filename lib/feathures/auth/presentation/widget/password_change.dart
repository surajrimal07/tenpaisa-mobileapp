// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class PasswordChangeDialog extends ConsumerWidget {
  const PasswordChangeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final formKey = GlobalKey<FormState>();
    final formKey = ref.watch(formKeyProvider);

    final passwordController = ref.watch(passwordControllerProvider);
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);
    String? passwordError;

    return AlertDialog(
      title: const Text("Change Password"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Current Password: *********"),
            SizedBox(height: Sizes.dynamicHeight(2)),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(value)) {
                  return 'Please enter a valid password';
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
              String newPassword = passwordController.text;
              if (newPassword.isNotEmpty) {
                ref
                    .read(authViewModelProvider.notifier)
                    .updateUser(auth.email, "password", newPassword, ref);

                if (!state.isLoading && state.error == null) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    passwordController.clear();
                    Navigator.pop(context);
                  });
                }
              }
            }
          },
          child: state.isLoading ? const ButtonLoading() : const Text("Save"),
        ),
        ElevatedButton(
          onPressed: () {
            passwordController.clear();
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
