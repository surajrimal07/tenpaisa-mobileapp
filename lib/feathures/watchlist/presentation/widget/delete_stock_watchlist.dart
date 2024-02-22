// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class DeleteStockConfirmationDialog extends ConsumerWidget {
  final WatchlistEntity watchlist;
  final String symbol;

  const DeleteStockConfirmationDialog({
    super.key,
    required this.watchlist,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(watchlistViewModelProvider);
    return AlertDialog(
      title: const Text('Remove Stock'),
      content: Text('$symbol will be removed?'),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ref
                .read(watchlistViewModelProvider.notifier)
                .removeStockFromWatchlist(watchlist.id, symbol);
            Navigator.of(context).pop(true);
          },
          child: state.isLoading ? const ButtonLoading() : const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
