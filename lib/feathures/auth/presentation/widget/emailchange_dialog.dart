// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class EmailChangeDialog extends ConsumerWidget {
  const EmailChangeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);
    //GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final formKey = ref.watch(formKeyProvider);

    return AlertDialog(
      title: const Text(EmailChangeDialogStrings.changeEmail),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${EmailChangeDialogStrings.currentEmail} : ${auth.email}"),
            SizedBox(height: Sizes.dynamicHeight(2)),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: EmailChangeDialogStrings.newEmail,
              ),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains("@")) {
                  return EmailChangeDialogStrings.invalidEmail;
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() == true) {
              ref.read(authViewModelProvider).resetError();

              await ref
                  .read(authViewModelProvider.notifier)
                  .updateUser(auth.email, "email", emailController.text, ref);

              if (!state.isLoading && state.error == null) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  emailController.clear();
                  Navigator.pop(context);
                });
                // emailController.clear();
                // Navigator.pop(context);
              }
            }

            // print("state.isLoading: ${state.isLoading}");
            // print("state.error: ${state.error}");
          },
          child: state.isLoading
              ? const ButtonLoading()
              : const Text(EmailChangeDialogStrings.save),
        ),
        ElevatedButton(
          onPressed: () {
            emailController.clear();
            Navigator.of(context).pop();
          },
          child: const Text(EmailChangeDialogStrings.cancel),
        ),
      ],
    );
  }
}
