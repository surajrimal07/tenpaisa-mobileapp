import 'dart:async';
import 'dart:convert';

import 'package:paisa/utils/serverconfig_utils.dart';

@override
void initState() {}

class PortfolioService {
  static get http => null;

  static Future<void> getasset(String symbol) async {
    var completer = Completer<void>();

    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.GET_ASSET}");

      var requestBody = {
        'symbol': symbol,
      };

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
        completer.completeError(500);
      }
    } catch (errpr) {
      completer.completeError(600);
    }
  }
}
