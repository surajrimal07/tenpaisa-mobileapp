// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class RenameWatchlistDialog extends ConsumerWidget {
  final String watchlistId;
  final String oldWatchlistName;

  const RenameWatchlistDialog(
      {super.key, required this.oldWatchlistName, required this.watchlistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(othersControllerProvider);
    final formKey = ref.watch(formKeyProvider);
    final state = ref.watch(watchlistViewModelProvider);

    return AlertDialog(
      title: const Text("Edit Portfolio Name"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Old Watchlist Name: $oldWatchlistName"),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller,
              decoration:
                  const InputDecoration(labelText: 'New Watchlist Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Watchlist name isempty';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() == true) {
              String watchlistName = controller.text;

              await ref
                  .read(watchlistViewModelProvider.notifier)
                  .renameWatchlist(watchlistId, watchlistName);

              controller.clear();
              Navigator.pop(context);
            }
          },
          child: state.isLoading ? const ButtonLoading() : const Text('Save'),
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
