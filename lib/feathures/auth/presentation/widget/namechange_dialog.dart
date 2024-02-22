// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class ChangeNameDialog extends ConsumerWidget {
  const ChangeNameDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameControllerProvider);
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);
    final formKey = ref.watch(formKeyProvider);

    // GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: const Text("Change Name"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Current Name: ${auth.name}"),
            SizedBox(height: Sizes.dynamicHeight(2)),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'New Name'),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(value)) {
                  return state.error ?? 'Please enter valid name';
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
              if (formKey.currentState?.validate() == true) {
                String newName = nameController.text;
                await ref
                    .read(authViewModelProvider.notifier)
                    .updateUser(auth.email, "name", newName, ref);
              }

              if (!state.isLoading && state.error == null) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  nameController.clear();
                  Navigator.pop(context);
                });
                // nameController.clear();
                // Navigator.pop(context);
              }
            },
            child:
                state.isLoading ? const ButtonLoading() : const Text("Save")),
        ElevatedButton(
          onPressed: () {
            nameController.clear();
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
