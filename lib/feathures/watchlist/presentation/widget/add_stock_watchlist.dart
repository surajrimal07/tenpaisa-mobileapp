// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class AddStockWatchlistDialog extends ConsumerWidget {
  final String watchlistId;
  final String watchlistName;

  const AddStockWatchlistDialog({
    super.key,
    required this.watchlistName,
    required this.watchlistId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller =
        ref.watch(searchControllerProvider);
    final formKey = ref.watch(formKeyProvider);
    final watchlistState = ref.watch(watchlistViewModelProvider);

    return AlertDialog(
      title: const Text("Add Stock"),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TypeAheadField<StockEntity>(
                controller: controller,
                hideOnEmpty: true,
                hideOnError: true,
                hideOnSelect: true,
                hideOnLoading: true,
                suggestionsCallback: (search) {
                  final List<StockEntity> stocks =
                      ref.read(stockViewModelProvider.notifier).state.stocks;

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
                  controller.text = search.symbol;
                },
                decorationBuilder: (context, child) {
                  return Material(
                    type: MaterialType.card,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  );
                },
                constraints: const BoxConstraints(maxHeight: 250),
                itemBuilder: (context, stock) {
                  return ListTile(
                    title: Text(stock.symbol),
                    subtitle: Text(stock.name),
                  );
                },
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Search for stock',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Stock cannot be empty';
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
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ref
                  .read(watchlistViewModelProvider.notifier)
                  .addStockToWatchlist(watchlistId, controller.text);
              Navigator.pop(context);
            }
          },
          child: watchlistState.isLoading
              ? const ButtonLoading()
              : const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            controller.clear();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
