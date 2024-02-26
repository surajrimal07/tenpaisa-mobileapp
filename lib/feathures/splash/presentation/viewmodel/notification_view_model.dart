import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/notification/notification_services.dart';

final notificationViewModelProvider = Provider<NotificationViewModel>(
  (ref) => NotificationViewModel(),
);

final unreadNewsCountProvider = StateProvider<int>((ref) {
  final notificationViewModel = ref.watch(notificationViewModelProvider);
  return notificationViewModel.unreadNews;
});

final unreadNotificationsCountProvider = StateProvider<int>((ref) {
  final notificationViewModel = ref.watch(notificationViewModelProvider);
  return notificationViewModel.unreadNotifications;
});

class NotificationViewModel extends ChangeNotifier {
  final NotificationServices notificationServices = NotificationServices();
  int unreadNotifications = 0;
  int unreadNews = 0;

  void onDataCallback(dynamic data) {
    Map<String, dynamic> newData = json.decode(data);

    String type = newData['type'];
    String receivedTitle = newData['title'];
    String receivedDescription = newData['description'];
    String? receivedImage =
        newData['image'] is String ? newData['image'] : null;

    String url = newData['url'];

    notificationServices.showBasicNotification(
        type, receivedTitle, receivedDescription, receivedImage, url);

    if (type == 'news') {
      unreadNews += 1;
      notifyListeners();
    } else {
      unreadNotifications += 1;
      notifyListeners();
    }
  }

  void clearUnreadNotifications() {
    unreadNotifications = 0;
    notifyListeners();
  }

  void clearUnreadNews() {
    unreadNews = 0;
    notifyListeners();
  }
}
