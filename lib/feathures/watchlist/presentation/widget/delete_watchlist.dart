// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class DeleteWatchlistDialog extends ConsumerWidget {
  final String watchlistId;
  final String watchlistName;

  const DeleteWatchlistDialog(
      {super.key, required this.watchlistId, required this.watchlistName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(watchlistViewModelProvider);
    return AlertDialog(
      title: const Text("Delete Portfolio"),
      content: Text("Are you sure you want to delete $watchlistName?"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ref
                .read(watchlistViewModelProvider.notifier)
                .deleteWatchlist(watchlistId);
            Navigator.pop(context);
          },
          child: state.isLoading ? const ButtonLoading() : const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
