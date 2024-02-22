import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';

class LoadMoneyDialog extends ConsumerStatefulWidget {
  const LoadMoneyDialog({super.key});

  @override
  LoadMoneyDialogState createState() => LoadMoneyDialogState();
}

// String? validateRadioButtons(int? selectedOption) {
//   if (selectedOption == null) {
//     return 'Please select a wallet';
//   }
//   return null;
// }

class LoadMoneyDialogState extends ConsumerState<LoadMoneyDialog> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final walletValue = ref.watch(authEntityProvider).wallets ?? 0;
    final formKey = ref.watch(formKeyProvider);
    final TextEditingController balanceController =
        ref.watch(quantityControllerProvider);
    final auth = ref.watch(authEntityProvider);
    final state = ref.watch(authViewModelProvider);
    return AlertDialog(
      title: const Text(WalletStrings.addMoney),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(WalletStrings.chooseWallet),
          if (walletValue == 1 || walletValue == 3)
            InkWell(
              onTap: () {
                setState(() {
                  _selectedOption = 0;
                });
              },
              child: ListTile(
                leading: Image.asset(
                  WalletStrings.khaltiImage,
                  width: 40,
                  height: 40,
                ),
                title: const Text(WalletStrings.khaltiText),
                trailing: Radio<int>(
                  value: 0,
                  groupValue: _selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
            ),
          if (walletValue == 2 || walletValue == 3)
            InkWell(
              onTap: () {
                setState(() {
                  _selectedOption = 1;
                });
              },
              child: ListTile(
                leading: Image.asset(
                  WalletStrings.esewaImage,
                  width: 30,
                  height: 30,
                ),
                title: const Text(WalletStrings.esewaText),
                trailing: Radio<int>(
                  value: 1,
                  groupValue: _selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
            ),
          const SizedBox(height: 10),
          if (walletValue == 1 || walletValue == 3 || walletValue == 2)
            Form(
              key: formKey,
              child: TextFormField(
                controller: balanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  prefixText: '  \u{0930}\u{0942}  ',
                  labelText: WalletStrings.enterAmount,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == '0') {
                    return 'Please enter amount';
                  }
                  final double? amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_selectedOption != null) {
              if (formKey.currentState?.validate() == true) {
                final oldBalance = auth.userAmount ?? 0;
                final newBalance =
                    int.parse(balanceController.text) + oldBalance;

                ref.read(authViewModelProvider.notifier).updateUser(
                      auth.email,
                      'useramount',
                      newBalance.toString(),
                      ref,
                    );

                if (!state.isLoading) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    balanceController.clear();
                    Navigator.pop(context);
                  });
                }
              }
            } else {
              CustomToast.showToast('Please select a wallet',
                  customType: Type.error);
            }
          },
          child: const Text(WalletStrings.proccedText),
        ),
        if (walletValue == 1 || walletValue == 2 || walletValue == 3)
          ElevatedButton(
            onPressed: () {
              balanceController.clear();
              Navigator.of(context).pop();
            },
            child: const Text(WalletStrings.cancelText),
          ),
      ],
    );
  }
}
