import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';

class WalletDialog extends ConsumerStatefulWidget {
  const WalletDialog({super.key});

  @override
  WalletDialogState createState() => WalletDialogState();
}

class WalletDialogState extends ConsumerState<WalletDialog> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final wallets = ref.watch(authEntityProvider).wallets ?? 0;

    return AlertDialog(
      title: const Text(WalletStrings.addWallet),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContent(wallets),
      ),
      actions: _buildActions(wallets, ref),
    );
  }

  List<Widget> _buildContent(wallets) {
    switch (wallets) {
      case 0:
        return [
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
        ];
      case 1:
        return [
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
        ];
      case 2:
        return [
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
        ];
      case 3:
        return [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'You have already added Khalti and eSewa as a wallet.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ];
      default:
        return [];
    }
  }

  List<Widget> _buildActions(wallets, ref) {
    final auth = ref.watch(authEntityProvider.select((it) => it.email));
    if (wallets == 3) {
      return [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Got It'),
        ),
      ];
    } else {
      return [
        ElevatedButton(
          onPressed: () {
            if (_selectedOption != null) {
              var id = 0;

              if (wallets == 0) {
                id = _selectedOption == 0 ? 1 : 2;
              } else if (wallets == 1) {
                id = 3;
              } else if (wallets == 2) {
                id = 3;
              }

              ref
                  .watch(authViewModelProvider.notifier)
                  .updateUser(auth, "wallets", id.toString(), ref);
              // CustomToast.showToast(
              //   'Esewa added successfully!',
              //   customType: Type.success,
              // );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pop();
              });
            } else {
              CustomToast.showToast(
                'Please select a wallet option',
                customType: Type.error,
              );
            }
          },
          child: const Text(WalletStrings.continueText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(WalletStrings.cancelText),
        ),
      ];
    }
  }
}
