import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart'; // Import this for ChangeNotifier
import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService with ChangeNotifier {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  String _userToken = "";

  String get userToken => _userToken;

  Future<void> _loadUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString('userToken') ?? "";
    notifyListeners();
  }

  Future<void> updateUserToken(String newToken) async {
    if (_userToken != newToken) {
      _userToken = newToken;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken', newToken);
      notifyListeners();
    }
  }

  static Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final UserService userService = UserService();
      await userService._loadUserToken();

      print("User token is ${userService.userToken}");

      if (userService.userToken.isEmpty) {
        CustomToast.showToast('User not logged in');
        return null;
      }

      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.VERIFY_API}");

      //print(url);

      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'token': userService.userToken}),
      );
      print("User token is ${userService.userToken}");
      print("Response status code: ${res.statusCode}");
      print("Response body: ${res.body}");

      if (res.statusCode == 200) {
        final userData = json.decode(res.body);
        return {
          'name': userData['username'],
          'email': userData['email'],
          'phone': userData['phone'],
          'dp': userData['picture'],
          'style': userData['style'],
        };
      } else {
        CustomToast.showToast('Failed to fetch user data: ${res.statusCode}');
        return null;
      }
    } catch (error) {
      CustomToast.showToast('Error fetching user data: $error');
      return null;
    }
  }

  static Future<void> updateUser(String field, String value) async {
    try {
      final UserService userService = UserService();
      await userService._loadUserToken();

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? userToken = userService.userToken;
      // print(userToken);

      var completer = Completer<void>();

      var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/updateuser");

      var requestBody = {
        'token': userService.userToken,
        'field': field,
        'value': value
      };

      //print("req body is 65 :  $requestBody");

      // if (userService.userToken != null) {
      //   requestBody['token'] = userService.userToken;
      // }
      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      //print("token : $userService.userToken value : $value");

      if (res.statusCode == 200) {
        CustomToast.showToast("Saved");
        completer.complete();
      } else {
        CustomToast.showToast("Error Occured Saving");
        completer.completeError("Error Occurred Saving");
      }
      return completer.future;
    } catch (error) {
      CustomToast.showToast("Error Occurred Saving: $error");
      return Future.error("Error Occurred Saving: $error");
    }
  }
}
