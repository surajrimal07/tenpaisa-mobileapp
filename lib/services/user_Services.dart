import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your server configuration class









  @override
  void initState() {

  }





//using shared preferenses here.

class UserService {
  static Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('userToken');

      print("User token is $userToken");

      if (userToken == null) {
        CustomToast.showToast('User not logged in');
        return null;
      }

      var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/verify");

      print(url);

      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'token': userToken}),
      );
      print("User token is $userToken");
      print("Response status code: ${res.statusCode}");
      print("Response body: ${res.body}");

      if (res.statusCode == 200) {
        final userData = json.decode(res.body);
        return {
          'name': userData['username'],
          'email': userData['email'],
          'phone': userData['phone'],
          'dp': userData['picture'],
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    print(userToken);
    var completer = Completer<void>();

    var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/updateuser");

    var requestBody = {'token': userToken, 'field': field, 'value': value};

    print("req body is 65 :  $requestBody");

    if (userToken != null) {
      requestBody['token'] =
          userToken; //unnecessary, just to make it run, usetoken is
      //never null here
    }
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    print("token : $userToken value : $value");

    if (res.statusCode == 200) {
      CustomToast.showToast("Saved");
      completer.complete();
    } else {
      CustomToast.showToast("Error Occured Saving");
      completer.completeError("Error Occurred Saving");
    }
    return completer.future;
  }
}
