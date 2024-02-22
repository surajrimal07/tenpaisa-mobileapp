// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

class AddStockFloatingDialog extends ConsumerStatefulWidget {
  final String? symbol;

  const AddStockFloatingDialog({
    super.key,
    this.symbol,
  });

  @override
  AddStockPortfolioDialogState createState() => AddStockPortfolioDialogState();
}

class AddStockPortfolioDialogState
    extends ConsumerState<AddStockFloatingDialog> {
  late TextEditingController _controller;

  String? _selectedPortfolio;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.symbol ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final portfolioNames =
        ref.watch(portfolioViewModelProvider.notifier).state.portfoliosEntity;
    final TextEditingController priceController =
        ref.watch(quantityControllerProvider);
    final TextEditingController quantityController =
        ref.watch(priceControllerProvider);
    final formKey = ref.watch(formKeyProvider);
    final state = ref.watch(portfolioViewModelProvider);

    return AlertDialog(
      title: const Text(PortfolioStrings.addStockText),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                  menuMaxHeight: Sizes.dynamicHeight(53),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  value: _selectedPortfolio,
                  onChanged: (value) {
                    setState(() {
                      _selectedPortfolio = value;
                    });
                  },
                  items: portfolioNames
                      .map(
                        (portfolio) => DropdownMenuItem(
                          value: portfolio.id,
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
                  }),
              SizedBox(height: Sizes.dynamicHeight(1.2)),
              TypeAheadField<StockEntity>(
                controller: _controller,
                hideOnEmpty: true,
                hideOnError: true,
                hideOnSelect: true,
                hideOnLoading: true,
                suggestionsCallback: (search) {
                  final List<StockEntity> stocks =
                      ref.watch(stockViewModelProvider.notifier).state.stocks;

                  return stocks
                      .where((stock) =>
                          stock.symbol
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          stock.name
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                      .toList();
                },
                onSelected: (search) {
                  _controller.text = search.symbol;
                },
                decorationBuilder: (context, child) {
                  return Material(
                    type: MaterialType.card,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  );
                },
                constraints: BoxConstraints(maxHeight: Sizes.dynamicHeight(40)),
                itemBuilder: (context, stock) {
                  return ListTile(
                    title: Text(stock.symbol),
                    subtitle: Text(stock.name),
                  );
                },
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: _controller,
                    focusNode: focusNode,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: PortfolioStrings.searchStock,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return PortfolioStrings.emptyStock;
                      }
                      return null;
                    },
                  );
                },
                loadingBuilder: (BuildContext context) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error) => const Text('Error!'),
                emptyBuilder: (context) => const Text('No items found!'),
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
              SizedBox(height: Sizes.dynamicHeight(1.2)),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  iconColor: AppColors.primaryColor,
                  errorStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  labelText: PortfolioStrings.stockQuantity,
                  prefixIcon: Icon(Icons.add_box),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return PortfolioStrings.emptyQuantity;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await ref
                  .read(portfolioViewModelProvider.notifier)
                  .addStockToPortfolio(
                    _selectedPortfolio!,
                    _controller.text,
                    int.parse(quantityController.text),
                    double.parse(priceController.text),
                  );

              _controller.clear();
              priceController.clear();
              quantityController.clear();
              Navigator.pop(context);
            }
          },
          child: state.isLoading
              ? const ButtonLoading()
              : const Text(PortfolioStrings.savePortfolio),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.clear();
            priceController.clear();
            quantityController.clear();
            Navigator.pop(context);
          },
          child: const Text(PortfolioStrings.cancelPortfolio),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
