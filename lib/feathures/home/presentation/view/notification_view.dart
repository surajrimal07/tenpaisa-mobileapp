import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/splash/presentation/viewmodel/notification_view_model.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationViewModel = ref.read(notificationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        actions: [
          IconButton(
            tooltip: 'Clear all notifications',
            onPressed: () {
              notificationViewModel.clearUnreadNotifications();
            },
            icon: const Icon(Icons.clear_all_outlined),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'No Notification found',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
