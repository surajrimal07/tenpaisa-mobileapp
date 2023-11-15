import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationController {
  static int displayedNotificationCount = 0;

  static int getDisplayedNotificationCount() {
    return displayedNotificationCount;
  }

  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {

  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Increment the displayed notification count
    displayedNotificationCount++;

    print('Displayed Notification Count: $displayedNotificationCount');
  }

  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    String? url = receivedAction.payload?['url'];

    if (url != null && url.isNotEmpty) {
      await _openLink(url);
    }
  }

  static Future<void> _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
