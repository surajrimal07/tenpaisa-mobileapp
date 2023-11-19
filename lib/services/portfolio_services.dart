import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/utils/serverconfig_utils.dart';

import '../services/user_services.dart';

@override
void initState() {}

class PortfolioService {
  static Future<List<Map<String, dynamic>>> getPort() async {
    final UserService userService = UserService();
    //await userService._loadUserToken();

    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.GET_PORT}");

      var requestBody = {
        'token': userService.userToken,
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return data;
      } else {
        throw Exception('Failed to fetch portfolio data');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}
