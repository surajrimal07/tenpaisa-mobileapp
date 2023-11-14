import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/services/notification_services.dart';
import 'package:paisa/services/websocket_services.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  late Future<void> channelInitialization; //starting noti
  late IOWebSocketChannel channel; //starting web socket listening
  String? userToken;

  @override
  void initState() {
    super.initState();
    checkFirstTime();

    channelInitialization =
        NotificationServices.initializeAwesomeNotifications();

    channel = WebSocketServices.startWebSocket(onDataCallback);
  }

  void checkFirstTime() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    dynamic loginsaved = prefs.get('loginsaved');

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }

    userToken = prefs.getString('userToken');

    Timer(const Duration(seconds: 1), () {
      if (isFirstTime == true) {
        Navigator.pushReplacementNamed(context, AppRoute.onboardRoute);
      } else if (userToken != null && loginsaved == true) {
        print("User token is true ");
        print("Login saved is $loginsaved");
        Navigator.pushReplacementNamed(context, AppRoute.dashboardRoute);

      } else {
        print("user token is false");
        Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
      }
    });
  }

  void onDataCallback(dynamic data) {
    Map<String, dynamic> newData = json.decode(data);
    String receivedTitle = newData['title'];
    String receivedDescription = newData['description'];
    String? receivedImage = newData['image'];
    String url = newData['url'];

    if (userToken != null) {
      NotificationServices.showNotification(
          receivedTitle, receivedDescription, receivedImage, url);
    } else {
      print("Noti Service: Auth ERROR");
      //CustomToast.showToast("Notification : Auth Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColors.btnColor,
              MyColors.btnColor
            ], // Set your desired gradient colors
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Image.asset('assets/logos/logo.png'),
          ),
        ),
      ),
    );
  }
}
