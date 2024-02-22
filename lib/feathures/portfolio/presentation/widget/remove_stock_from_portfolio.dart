// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

final selectedPortfolioIdProvider =
    StateProvider.autoDispose<String?>((ref) => null);

class DeleteStockDialog extends ConsumerStatefulWidget {
  final String stockSymbol;

  const DeleteStockDialog({super.key, required this.stockSymbol});

  @override
  DeleteStockPortfolioState createState() => DeleteStockPortfolioState();
}

class DeleteStockPortfolioState extends ConsumerState<DeleteStockDialog> {
  // final TextEditingController quantityController = TextEditingController();
  String? selectedPortfolioId;
  UserPortfolioStockEntity? selectedStockInPortfolio;
  int selectedStockQuantity = 0;

  // @override
  // void dispose() {
  //   // quantityController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final formKey = ref.watch(formKeyProvider);

    final TextEditingController quantityController =
        ref.watch(priceControllerProvider);
    final state = ref.watch(portfolioViewModelProvider);

    final portfolios =
        ref.watch(portfolioViewModelProvider.notifier).state.portfoliosEntity;

    final portfoliosWithStock = portfolios.where((portfolio) =>
        portfolio.stocks != null &&
        portfolio.stocks!.any((stock) => stock.symbol == widget.stockSymbol));

    return AlertDialog(
      title: const Text(PortfolioStrings.deleteStock),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select Portfolio to Delete ${widget.stockSymbol} From:"),
              const SizedBox(height: 20),
              if (portfoliosWithStock.isEmpty)
                const Text(
                  PortfolioStrings.nostocks,
                  style: TextStyle(color: Colors.red),
                )
              else
                Column(
                  children: [
                    DropdownButtonFormField<PortfolioEntity>(
                      value: selectedPortfolioId != null
                          ? portfoliosWithStock.firstWhere((portfolio) =>
                              portfolio.id == selectedPortfolioId)
                          : null,
                      onChanged: (value) {
                        setState(() {
                          selectedPortfolioId = value?.id;
                          ref.read(selectedPortfolioIdProvider.notifier).state =
                              selectedPortfolioId;
                          selectedStockInPortfolio = value?.stocks?.firstWhere(
                              (stock) => stock.symbol == widget.stockSymbol);
                          selectedStockQuantity =
                              selectedStockInPortfolio?.quantity ?? 0;
                        });
                      },
                      items: portfoliosWithStock
                          .map(
                            (portfolio) => DropdownMenuItem(
                              value: portfolio,
                              child: Text(portfolio.name),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: PortfolioStrings.selectPortfolio,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return PortfolioStrings.noPortfolioSelected;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Sizes.dynamicHeight(1.2)),
                    TextFormField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: PortfolioStrings.quantityText,
                        prefixIcon: Icon(Icons.add_box),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return PortfolioStrings.emptyQuantity;
                        }
                        final int enteredQuantity = int.tryParse(value) ?? 0;
                        if (enteredQuantity > selectedStockQuantity) {
                          return '${PortfolioStrings.quantityGreater} $selectedStockQuantity';
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
      actions: portfoliosWithStock.isEmpty
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
                    await ref
                        .read(portfolioViewModelProvider.notifier)
                        .removeStockToPortfolio(
                          selectedPortfolioId!,
                          widget.stockSymbol,
                          int.tryParse(quantityController.text) ?? 0,
                        );

                    Navigator.pop(context);
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
}
