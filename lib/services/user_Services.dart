import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your server configuration class

@override
void initState() {}

class UserService {
  String? _userToken;

  String? get userToken => _userToken;

//load token
  Future<void> _loadUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString('userToken');
  }

  //delete token
  Future<void> deleteUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    _userToken = null;
  }

//create token
  static Future<String> createToken(String email, String pass) async {
    final completer = Completer<String>();
    try {
      final key = utf8.encode('$email$pass');
      final hmacSha256 = Hmac(sha256, key);
      final digest = hmacSha256.convert(Uint8List.fromList(key));
      final userToken1 = digest.toString();
      completer.complete(userToken1);
    } catch (error) {
      completer.completeError(error.toString());
    }
    return completer.future;
  }

//save token
  static Future<void> saveUserToken(String email, String pass) async {
    var completer = Completer<void>();

    var userToken = "";
    try {
      userToken = await UserService.createToken(email, pass);
    } catch (error) {
      //print("Failed to generate token"); //remove this later
    }

    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.SAVE_TOKEN}");

      var requestBody = {'email': email, 'token': userToken};

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        completer.complete();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', userToken);
      } else {
        completer.completeError("400"); //failed to save token
      }
    } catch (e) {
      completer.completeError("500"); //("Token error");
    }
    return completer.future;
  }

//login
  static Future<void> login(String email, String pass, bool remember) async {
    var completer = Completer<void>();

    var url = Uri.parse(
        "${ServerConfig.SERVER_ADDRESS}${ServerConfig.LOGIN}"); //replace this with localhost ip address
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': pass,
      }),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (res.statusCode == 200) {
      //print("we are here 86");
      try {
        await saveUserToken(email, pass);
        completer.complete();
        //CustomToast.showToast("Signin Successful");

        //SharedPreferences prefs = await SharedPreferences.getInstance();

        if (remember == true) {
          prefs.setBool('loginsaved', true);
        }
      } catch (e) {
        completer.completeError("400");
        //CustomToast.showToast("Token Error");
      }
    } else {
      completer.completeError("401");
      //print("401 103 line of login");
      //CustomToast.showToast("Email or password is incorrect");
    }
    return completer.future;
  }

//fetch user data
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

  static Future<void> preVerify(String value, String fields) async {
    var completer = Completer<void>();
    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.PRE_VERIFY}");

      var requestBody = {'field': fields, 'value': value};

      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (res.statusCode == 200) {
        completer.complete();
      } else {
        completer.completeError("400");
      }
    } catch (error) {
      completer.completeError(error);
      rethrow;
    }
    return completer.future;
  }

//update user
  static Future<void> updateUser(
    String field,
    String value,
    String? email,
  ) async {
    final UserService userService =
        UserService(); //String? is for special purpose like when in password reset view where we don't have any token
    await userService._loadUserToken();

    var completer = Completer<void>();

    var url =
        Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.UPDATE_USER}");

    var requestBody = {
      'email': email,
      'token': userService.userToken,
      'field': field,
      'value': value
    };

    print(requestBody);
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (res.statusCode == 200) {
      completer.complete();
    } else if (res.statusCode == 400) {
      completer.completeError("400");
    } else {
      completer.completeError("500");
    }
    return completer.future;
  }

//delete user
  static Future<void> deleteUser(String password) async {
    final UserService userService = UserService();
    await userService._loadUserToken();

    var completer = Completer<void>();
    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.DELETE_USER}");

      var requestBody = {'token': userService.userToken, 'password': password};
      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      print(res);

      if (res.statusCode == 200) {
        completer.complete();
      } else if (res.statusCode == 401) {
        completer.completeError("401");
      }
    } catch (error) {
      completer.completeError(500);
    }
    return completer.future;
  }

//verify otp
  static Future<void> verifyOTP(String email, String otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? temphash = prefs.getString('otphash');

    var completer = Completer<void>();

    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.OTP_VERIFY}");

      var requestBody = {'email': email, 'hash': temphash, 'otp': otp};
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        completer.complete();
      } else {
        completer.completeError(400);
      }
    } catch (e) {
      completer.completeError(600);
    }
    return completer.future;
  }

//register
  static Future<void> signupUser(
      String name, String email, String phone, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var completer = Completer<void>();

    var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.SIGNUP}");

    try {
      var requestBody = {'email': email};

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var result = response.body;
        Map<String, dynamic> parsedResponse = json.decode(result);
        String dataValue = parsedResponse['data'];
        prefs.setString('otphash', dataValue);

        //userService.setTempHash(dataValue);

        ///setting hash value here
        print("hash is $dataValue");

        //trigger verify otp function and pass datatopass
        completer.complete();
      }
      // else if (response.statusCode == 400) {
      //   completer.completeError("401");}
      else {
        completer.completeError("300");
        CustomToast.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      completer.completeError("500");
      CustomToast.showToast("Network error: $e");
    }

    return completer.future;
  }

  static Future<void> savedata(
      String name, String email, String password, String phone) async {
    var completer = Completer<void>();

    var userToken = "";

    try {
      userToken = await UserService.createToken(email, password);
      print("Fresh token generated is : $userToken");
    } catch (error) {
      print("Failed to generate token"); //remove this later
    }

    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.SAVE_USER}");

      // Create a map for the request body
      var requestBody = {
        'token': userToken,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        //completer.isCompleted();     //if code dosen't detect completed task use this
        //completer.complete();
        //CustomToast.showToast("User Created Successfully");

        try {
          await saveUserToken(email, password);
          completer.complete();
        } catch (e) {
          completer.completeError("300"); //tokenerror
        }
      } else {
        completer.completeError(500);
      }
    } catch (errpr) {
      completer.completeError(600);
    }
  }

  static Future<void> resendOTP(String email) async {
    var completer = Completer<void>();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.OTP_LOGIN}"); //create

      var requestBody = {'email': email};

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var result = response.body;
        Map<String, dynamic> parsedResponse = json.decode(result);
        String dataValue = parsedResponse['data'];
        prefs.setString('otphash', dataValue);

        completer.complete();
      } else if (response.statusCode == 400) {
        completer.completeError(400);
      } else {
        completer.completeError(500);
      }
    } catch (error) {
      completer.completeError(error);
    }
  }

  static Future<void> forget(String email) async {
    var completer = Completer<void>();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.FORGET}"); //replace this with localhost ip address

      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      if (res.statusCode == 200) {
        var result = res.body;

        Map<String, dynamic> parsedResponse = json.decode(result);
        String dataValue = parsedResponse['hash'];
        prefs.setString('otphash', dataValue);

        completer.complete();
      } else if (res.statusCode == 404) {
        completer.completeError(404); //mail not found
      }
    } catch (error) {
      completer.completeError(error);
    }
  }
}
