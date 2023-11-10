import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:web_socket_channel/io.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int indexBottomBar = 1;
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();

    try {
      channel = IOWebSocketChannel.connect('ws://192.168.101.7:8081');

      AwesomeNotifications().initialize('resource://drawable/ic_launcher.png', [
        NotificationChannel(
          channelKey: 'news_channel',
          channelName: 'News',
          channelDescription: 'Stock News',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: MyColors.btnColor,
          ledColor: Colors.amber,
        )
      ]);

      channel.stream.listen(
        (message) {
          onData(message);
        },
        onError: (error) {
          CustomToast.showToast("Socket: Error $error ");
          //print('Error: $error');
          // Handle the WebSocket connection error
          handleSocketError(error);
        },
        onDone: () {
          CustomToast.showToast("Socket: Connection closed");
          //print('Connection closed');
        },
      );
    } on SocketException catch (e) {
      CustomToast.showToast("SocketException: ${e.message}");
      //print('SocketException: ${e.message}');
      // Handle SocketException error (if needed)
      handleSocketError(e);
    } catch (e) {
      CustomToast.showToast("SocketException: $e");
      //print('Exception: $e');
      // Handle other exceptions (if needed)
      //CustomToast.showToast("Socket Error");
      handleSocketError(e);
    }
  }

  void handleSocketError(dynamic error) {
    // Implement your error handling logic here
    // For example: Display an error message, retry logic, etc.
  }

  Future<void> showNotification(
      String title, String description, String image) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'news_channel',
        title: title,
        body: description,
        bigPicture: image,
        largeIcon: image,
        notificationLayout: NotificationLayout.BigPicture,
        payload: {'notificationId': '1234567890'},
      ),
    );
  }

  void onData(dynamic data) {
    Map<String, dynamic> newData = json.decode(data);
    String receivedTitle = newData['title'];
    String receivedDescription = newData['description'];
    String receivedimage = newData['image'];

    showNotification(receivedTitle, receivedDescription, receivedimage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
        child: Text(
          'Under Development',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, AppRoute.newsRoute);
          } else if (i == 1) {
            // If the user taps on the current tab (index 1), no need to change the route
          } else {
            setState(() => indexBottomBar = i);
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.paperclip_2),
            title: const Text("News"),
            selectedColor: MyColors.btnColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.notification),
            title: const Text("Notification"),
            selectedColor: MyColors.btnColor,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
