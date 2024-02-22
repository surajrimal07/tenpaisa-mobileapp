// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

final selectedStockProvider =
    StateProvider.autoDispose<UserPortfolioStockEntity?>((ref) => null);

class DeleteStockPortfolioDialog extends ConsumerWidget {
  final String portfolioId;
  final String portfolioName;
  final List<UserPortfolioStockEntity>? stocksInPortfolio;

  const DeleteStockPortfolioDialog({
    super.key,
    required this.portfolioId,
    required this.portfolioName,
    required this.stocksInPortfolio,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(formKeyProvider);

    final quantityController = ref.watch(quantityControllerProvider);
    final availableStocks = stocksInPortfolio ?? [];
    final selectedStock = ref.watch(selectedStockProvider);
    final state = ref.watch(portfolioViewModelProvider);
    final priceController = ref.watch(priceControllerProvider);
    final user = ref.watch(authEntityProvider);

    return AlertDialog(
      title: const Text(PortfolioStrings.deleteStock),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${PortfolioStrings.removeStockFrom} $portfolioName"),
              Text("Your Balance : Rs ${user.userAmount}"),
              SizedBox(height: Sizes.dynamicHeight(1.4)),
              if (availableStocks.isEmpty)
                const Text(
                  PortfolioStrings.emptyStocks,
                  style: TextStyle(color: Colors.red),
                )
              else
                Column(
                  children: [
                    DropdownButtonFormField<UserPortfolioStockEntity>(
                      menuMaxHeight: Sizes.dynamicHeight(35),
                      value: selectedStock,
                      onChanged: (value) {
                        ref.read(selectedStockProvider.notifier).state = value;
                      },
                      items: availableStocks
                          .map(
                            (stock) => DropdownMenuItem(
                              value: stock,
                              child: Text(stock.symbol),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                          labelText: PortfolioStrings.selectStock),
                      validator: (value) {
                        if (value == null) {
                          return PortfolioStrings.selectStockText;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Sizes.dynamicHeight(1.2)),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        labelText: PortfolioStrings.stockPrice,
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return PortfolioStrings.emptyPrice;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Sizes.dynamicHeight(1.4)),
                    TextFormField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: PortfolioStrings.stockQuantity,
                        prefixIcon: Icon(Icons.add_box),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return PortfolioStrings.emptyQuantity;
                        }
                        final int enteredQuantity = int.tryParse(value) ?? 0;
                        if (enteredQuantity > (selectedStock?.quantity ?? 0)) {
                          return '${PortfolioStrings.quantityGreater} ${selectedStock?.quantity}';
                        }
                        return null;
                      },
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
      actions: availableStocks.isEmpty
          ? [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(PortfolioStrings.sureText),
              ),
            ]
          : [
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() == true) {
                    _deleteStock(context, ref, quantityController.text,
                        priceController.text, state, user);
                  }
                },
                child: state.isLoading
                    ? const ButtonLoading()
                    : const Text(PortfolioStrings.deletePort),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(PortfolioStrings.cancelPortfolio),
              ),
            ],
    );
  }

  void _deleteStock(BuildContext context, WidgetRef ref, quantity, price,
      portState, user) async {
    final selectedStock = ref.watch(selectedStockProvider.notifier).state;
    int totalAmount = int.parse(quantity) * int.parse(price);
    final newAmount = user.userAmount! + totalAmount;

    await ref.read(portfolioViewModelProvider.notifier).removeStockToPortfolio(
          portfolioId,
          selectedStock!.symbol,
          int.tryParse(quantity) ?? 0,
        );
    if (!portState.isLoading) {
      ref.read(authViewModelProvider.notifier).updateUser(
            user.email,
            'useramount',
            newAmount.toString(),
            ref,
          );

      Future.delayed(const Duration(milliseconds: 500), () {
        ref.watch(quantityControllerProvider).clear();
        Navigator.pop(context);
      });
    }
  }
}
