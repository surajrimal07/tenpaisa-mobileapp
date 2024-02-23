import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/home/presentation/widget/data_decode.dart';

class InvestmentStyleChangeDialog extends ConsumerWidget {
  const InvestmentStyleChangeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentStyleController = ref.watch(quantityControllerProvider);
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);
    final formKey = ref.watch(formKeyProvider);

    return AlertDialog(
      title: const Text('Change Investment Style'),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Current Investment Style: ${decodeInvStyle(auth.invstyle ?? 0)}'),
            SizedBox(height: Sizes.dynamicHeight(2)),
            DropdownButtonFormField<int>(
              value: auth.invstyle,
              onChanged: (newValue) {
                investmentStyleController.text = newValue.toString();
              },
              items: const [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text(StyleStrings.option3),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text(StyleStrings.option4),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text(StyleStrings.option5),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Text(StyleStrings.option6),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              //if (formKey.currentState?.validate() == true) {
              await ref.read(authViewModelProvider.notifier).updateUser(
                  auth.email, "style", investmentStyleController.text, ref);

              if (!state.isLoading) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  investmentStyleController.clear();
                  Navigator.pop(context);
                });
              }
            }
          },
          child: state.isLoading ? const ButtonLoading() : const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            investmentStyleController.clear();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
