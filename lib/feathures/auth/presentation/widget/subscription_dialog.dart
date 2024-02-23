// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class PremiumSubscriptionDialog extends ConsumerStatefulWidget {
  const PremiumSubscriptionDialog({super.key});

  @override
  _PremiumSubscriptionDialogState createState() =>
      _PremiumSubscriptionDialogState();
}

class _PremiumSubscriptionDialogState
    extends ConsumerState<PremiumSubscriptionDialog> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);
    final formKey = ref.watch(formKeyProvider);

    if (auth.premium == true) {
      return AlertDialog(
        title: const Text(SubsString.premiumSubs),
        content: const Text(SubsString.premiumSubsText),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text('Ok'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: const Text(SubsString.purchasePremium),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(SubsString.choosePackage),
            SizedBox(height: Sizes.dynamicHeight(2)),
            Row(
              children: [
                Radio<int>(
                  value: 250,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                const Text('Rs 250 for 6 months'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 500,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                const Text('Rs 450 for 12 months'),
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
              final userAmount =
                  ref.watch(authEntityProvider.select((it) => it.userAmount));

              if (_selectedOption != null) {
                final subscriptionAmount = _selectedOption == 250 ? 250 : 450;

                if (userAmount! >= subscriptionAmount) {
                  await ref
                      .read(authViewModelProvider.notifier)
                      .updateUser(auth.email, "premium", "true", ref);

                  final updatedUserAmount = userAmount - subscriptionAmount;
                  ref.read(authViewModelProvider.notifier).updateUser(
                        auth.email,
                        'useramount',
                        updatedUserAmount.toString(),
                        ref,
                      );

                  CustomToast.showToast(
                    SubsString.thankYou,
                    customType: Type.success,
                  );

                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                } else {
                  CustomToast.showToast(
                    SubsString.noBalance,
                    customType: Type.error,
                  );
                }
              } else {
                CustomToast.showToast(
                  SubsString.subsNotSelected,
                  customType: Type.error,
                );
              }
            }
          },
          child:
              state.isLoading ? const ButtonLoading() : const Text('Purchase'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
