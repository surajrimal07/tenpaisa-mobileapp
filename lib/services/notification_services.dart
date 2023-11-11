// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:paisa/utils/colors_utils.dart';

class NotificationServices {
  static Future<void> initializeAwesomeNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://raw/ic_launcher',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'stocknews',
          channelDescription: 'Stock News',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          defaultColor: MyColors.btnColor,
          channelShowBadge: true,
          //soundSource: 'noti.mp3', //'resource://raw/noti.ogg',
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
      ],
      debug: false,
    );
  }

  static Future<void> showNotification(
      String title, String description, String? image, String url) async {
    String defaultImagePath = 'resource://raw/news';
    String selectedImagePath = image ?? defaultImagePath;

    //image vayo
    //noti icon vayo

    //to do
    //sound
    //on click

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

//really finding it hard to listen for notification events, will do it later

  // static Future<void> handleNotificationAction(String buttonKey,
  //     Map<String, dynamic>? payload, BuildContext context) async {
  //   if (buttonKey == 'open_link') {
  //     String? url = payload?['url'];
  //     print(url);
  //     if (url != null && url.isNotEmpty) {
  //       print("74 launch url initiated");
  //       if (context != null) {
  //         _launchURL(url, context);
  //       } else {
  //         print('Context is null');
  //       }
  //     }
  //   }
  // }

  // static Future<void> _launchURL(String url, BuildContext context) async {
  //   print('Launching URL: $url');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userToken = prefs.getString('userToken');

  //   try {
  //     if (await canLaunchUrl(Uri.parse(url))) {
  //       if (userToken != null && userToken.isNotEmpty) {
  //         Navigator.pushNamed(context, AppRoute.newsRoute,
  //             arguments: {'url': url});
  //       } else {
  //         await launchUrl(Uri.parse(url));
  //       }
  //       print('URL launched successfully');
  //     } else {
  //       print('Could not launch $url');
  //     }
  //   } catch (e) {
  //     print('Error launching URL: $e');
  //   }
  // }
}
