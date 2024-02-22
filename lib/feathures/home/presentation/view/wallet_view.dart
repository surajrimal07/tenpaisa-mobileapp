import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/home/presentation/widget/add_money_dialog.dart';
import 'package:paisa/feathures/home/presentation/widget/add_wallet.dart';
import 'package:paisa/feathures/home/presentation/widget/data_decode.dart';

class WalletViews extends ConsumerWidget {
  const WalletViews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authEntityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(WalletStrings.wallet),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: const Text(WalletStrings.addMoney),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const LoadMoneyDialog();
                        },
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: const Text(WalletStrings.addWallet),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const WalletDialog();
                        },
                      );
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 111, 170, 124),
                      Color(0xFF90E8A5)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        WalletStrings.yourWalletAmount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Sizes.dynamicHeight(0.9)),
                      Text(
                        'Rs: ${auth.userAmount}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Sizes.dynamicHeight(0.7)),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      WalletStrings.yourWallets,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (auth.wallets == 0)
                      const Text(
                        WalletStrings.noWalletAdded,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    if (auth.wallets == 1 || auth.wallets == 2)
                      Row(
                        children: [
                          Image.asset(
                            auth.wallets == 1
                                ? WalletStrings.khaltiImage
                                : WalletStrings.esewaImage,
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            getWalletInfo(auth.wallets ?? 0),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    if (auth.wallets == 3)
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                WalletStrings.khaltiImage,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                WalletStrings.khaltiText,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Image.asset(
                                WalletStrings.esewaImage,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                WalletStrings.esewaText,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
