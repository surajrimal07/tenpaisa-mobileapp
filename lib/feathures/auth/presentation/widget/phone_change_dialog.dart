import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class PhoneChangeDialog extends ConsumerWidget {
  const PhoneChangeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final formKey = GlobalKey<FormState>();
    final formKey = ref.watch(formKeyProvider);

    final phoneController = ref.watch(phoneControllerProvider);
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);

    return AlertDialog(
      title: const Text(PhoneChangeDialogStrings.changePhone),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${PhoneChangeDialogStrings.currentPhone} : ${auth.phone}",
            ),
            SizedBox(height: Sizes.dynamicHeight(4)),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: PhoneChangeDialogStrings.newPhone,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.length != 10 ||
                    int.tryParse(value) == null) {
                  return PhoneChangeDialogStrings.invalidPhone;
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
              String newPhone = phoneController.text;
              ref
                  .read(authViewModelProvider.notifier)
                  .updateUser(auth.email, "phone", newPhone, ref);
            }
            if (!state.isLoading && state.error == null) {
              Future.delayed(const Duration(milliseconds: 500), () {
                phoneController.clear();
                Navigator.pop(context);
              });
            }
          },
          child: state.isLoading ? const ButtonLoading() : const Text("Save"),
        ),
        ElevatedButton(
          onPressed: () {
            phoneController.clear();
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
