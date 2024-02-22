// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class RemStockWatchlistDialog extends ConsumerStatefulWidget {
  final String stockSymbol;

  const RemStockWatchlistDialog({
    super.key,
    required this.stockSymbol,
  });

  @override
  AddStockWatchlistDialogState createState() => AddStockWatchlistDialogState();
}

class AddStockWatchlistDialogState
    extends ConsumerState<RemStockWatchlistDialog> {
  String? _selectedWatchlistId;

  @override
  Widget build(BuildContext context) {
    final formKey = ref.watch(formKeyProvider);
    final state = ref.watch(watchlistViewModelProvider);

    final watchlists = ref
        .watch(watchlistViewModelProvider.notifier)
        .state
        .watchlist
        .where((watchlist) => watchlist.stocks.contains(widget.stockSymbol))
        .toList();
    return AlertDialog(
      title: const Text("Remove Stock"),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedWatchlistId,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a watchlist';
                  }
                  return null;
                },
                items: watchlists
                    .map((watchlist) => DropdownMenuItem(
                          value: watchlist.id,
                          child: Text(watchlist.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedWatchlistId = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select watchlist',
                ),
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
                  .read(watchlistViewModelProvider.notifier)
                  .removeStockFromWatchlist(
                      _selectedWatchlistId!, widget.stockSymbol);
              Navigator.pop(context);
            }
          },
          child: state.isLoading ? const ButtonLoading() : const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
