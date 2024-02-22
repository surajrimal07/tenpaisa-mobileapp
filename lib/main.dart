import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/network/hive_service.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();

  AwesomeNotifications().initialize(
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
        defaultColor: AppColors.btnColor,
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ],
    debug: false,
  );

  runApp(const ProviderScope(child: App()));
}
