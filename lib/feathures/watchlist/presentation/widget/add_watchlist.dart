// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class CreateWatchlistDialog extends ConsumerWidget {
  const CreateWatchlistDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(othersControllerProvider);
    final state = ref.watch(watchlistViewModelProvider);
    final formKey = ref.watch(formKeyProvider);

    return AlertDialog(
      title: const Text("Create Watchlist"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Watchlist Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Watchlist name is empty';
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
              await ref
                  .read(watchlistViewModelProvider.notifier)
                  .createWatchlist(nameController.text);

              if (state.error == null) {
                nameController.clear();
                Navigator.pop(context);
              }
            }
          },
          child: state.isLoading ? const ButtonLoading() : const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            nameController.clear();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
