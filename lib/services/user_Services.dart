import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your server configuration class

@override
void initState() {}
//using shared preferenses here.

class UserService {
  String? _userToken;

  String? get userToken => _userToken;

  Future<void> _loadUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString('userToken');
  }

  Future<void> deleteUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    _userToken = null;
  }

  Future<void> saveUserToken(String newToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = newToken;
    await prefs.setString('userToken', newToken);
  }

  static Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final UserService userService = UserService();
      await userService._loadUserToken();

      if (userService.userToken == null || userService.userToken!.isEmpty) {
        CustomToast.showToast('User not logged in');
        return null;
      }

      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.VERIFY_API}");

      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'token': userService.userToken ?? ''
        }), //just to avoid ? null error, however usertoken will never be null here
      );

      if (res.statusCode == 200) {
        final userData = json.decode(res.body);

        String imageBaseUrl = 'assets/images/content/';

        return {
          'name': userData['username'],
          'email': userData['email'],
          'pass': "**********",
          'phone': userData['phone'] ?? "",
          'dp': imageBaseUrl +
              (userData['picture'] ??
                  'default.png'), //"assets/images/content/default.png",
          'style': userData['style'] ?? 0,
        };
      } else {
        CustomToast.showToast('Failed to fetch user data: ${res.statusCode}');
        return null; //return statuscode here
      }
    } catch (error) {
      CustomToast.showToast('Error fetching user data: $error');
      return null;
    }
  }

  static Future<void> updateUser(String field, String value) async {
    final UserService userService = UserService();
    await userService._loadUserToken();

    var completer = Completer<void>();

    var url =
        Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.UPDATE_USER}");

    var requestBody = {
      'token': userService.userToken,
      'field': field,
      'value': value
    };

    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (res.statusCode == 200) {
      //print(userService.userToken);
      //CustomToast.showToast("Saved");
      completer.complete();
    } else if (res.statusCode == 400) {
      completer.completeError("400");
    } else {
      //CustomToast.showToast("Error Occured Saving");
      completer.completeError("500");
    }
    return completer.future;
  }

  static Future<void> deleteUser(String password) async {
    final UserService userService = UserService();
    await userService._loadUserToken();

    var completer = Completer<void>();

    var url =
        Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.DELETE_USER}");

    var requestBody = {'token': userService.userToken, 'password': password};
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (res.statusCode == 200) {
      //print(userService.userToken);
      //CustomToast.showToast("Saved");
      completer.complete();
    } else if (res.statusCode == 401) {
      completer.completeError("401");
    } else {
      //CustomToast.showToast("Error Occured Saving");
      completer.completeError("500");
    }
    return completer.future;
  }








  
}
