// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/themes/app_themes.dart';

final notificationServiceProvider = Provider<NotificationServices>((ref) {
  return NotificationServices();
});

class NotificationServices {
//this can be removed later //no need
  static Future<void> showNotification(
      String title, String description, String? image, String url) async {
    String defaultImagePath = 'resource://raw/news';
    String selectedImagePath = image ?? defaultImagePath;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'basic_channel',
        title: title,
        body: description,
        bigPicture: selectedImagePath,
        largeIcon: selectedImagePath,
        notificationLayout: image != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        actionType: ActionType.KeepOnTop,
        payload: {'notificationId': '1234567890', 'url': url},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'open_link',
          label: 'Open Link',
        ),
      ],
    );
  }

//only for local notifications
  static Future<void> showLocalNotification(
      String title, String description, String? image) async {
    String defaultImagePath = 'resource://raw/news';
    String selectedImagePath = image ?? defaultImagePath;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'basic_channel',
        title: title,
        body: description,
        bigPicture: selectedImagePath,
        largeIcon: selectedImagePath,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        actionType: ActionType.KeepOnTop,
      ),
    );
  }

//unified solution that leaves server to determine what type of notification to show
  // static Future<void> showBasicNotification(String type, String title,
  Future<void> showBasicNotification(String type, String title,
      String description, String? image, String url) async {
    String defaultImagePath = 'resource://raw/news';
    String selectedImagePath = image ?? defaultImagePath;

    if (type == 'news') {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'basic_channel',
          title: title,
          body: description,
          bigPicture: selectedImagePath,
          largeIcon: selectedImagePath,
          notificationLayout: image != null
              ? NotificationLayout.BigPicture
              : NotificationLayout.Default,
          displayOnBackground: true,
          displayOnForeground: true,
          wakeUpScreen: true,
          actionType: ActionType.KeepOnTop,
          payload: {'notificationId': '1234567890', 'url': url},
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'open_link',
              label: 'Open Link',
              color: AppColors.primaryColor

              //actionType: ActionButtonType.OpenApp,
              ),
        ],
      );
    } else if (type == 'notification') {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'basic_channel',
          title: title,
          body: description,
          bigPicture: selectedImagePath,
          largeIcon: selectedImagePath,
          displayOnBackground: true,
          displayOnForeground: true,
          wakeUpScreen: true,
          actionType: ActionType.KeepOnTop,
        ),
      );
    } else {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'basic_channel',
            title: title,
            body: description,
            bigPicture: selectedImagePath,
            largeIcon: selectedImagePath,
            displayOnBackground: true,
            displayOnForeground: true,
            wakeUpScreen: true,
            actionType: ActionType.KeepOnTop),
      );
    }
  }

  //listen to notification click events
  // static void listenToNotificationClickEvent() {
  //   AwesomeNotifications().actionStream.listen((receivedNotification) {
  //     print('Received notification: $receivedNotification');
  //   });
  // }
}
