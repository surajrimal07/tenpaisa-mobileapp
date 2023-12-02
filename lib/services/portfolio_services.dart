import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';

import '../services/user_services.dart';

class PortfolioService {
//working
  static Future<void> createPort(String name) async {
    final UserService userService = UserService();
    var completer = Completer<void>();

    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.CREATE_PORTFOLIO}");

      var requestBody = {'token': userService.userToken, 'name': name};

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        completer.complete();
      } else if (response.statusCode == 400) {
        CustomToast.showToast("Duplicate Portfolio Name");
        completer.completeError(400);
      } else {
        completer.completeError(500);
        throw Exception('Failed to create portfolio');
      }
    } catch (error) {
      completer.completeError(600);
    }
    return completer.future;
  }

//get portfolio data //works
  static Future<List<Map<String, dynamic>>> getPortfolio() async {
    final UserService userService = UserService();

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
        Map<String, dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> portfolios =
            List<Map<String, dynamic>>.from(responseData['portfolios']);
        return portfolios;
      } else {
        throw Exception('Failed to fetch portfolio data');
      }
    } catch (error) {
      throw Exception('Portfolio error occurred: $error');
    }
  }

//add to portfolio working
  static Future<Map<String, dynamic>> addtoPort(
      int id, String symbol, int quantity, int price) async {
    final UserService userService = UserService();

    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.ADD_STOCK_TO_PORTFOLIO}");

      var requestBody = {
        'token': userService.userToken,
        'id': id,
        'symbol': symbol,
        'quantity': quantity,
        'price': price
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to add to portfolio');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//delete stock from portfolio
  static Future<void> deletestockfromport(
      int id, String symbol, int quantity) async {
    final UserService userService = UserService();

    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.REM_STOCK_TO_PORTFOLIO}");

      var requestBody = {
        'token': userService.userToken,
        'id': id,
        'symbol': symbol,
        'quantity': quantity
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
      } else if (response.statusCode == 404) {
        CustomToast.showToast("Stock not found");
        throw Exception("Stock not found");
      } else {
        CustomToast.showToast("Error occurred");
        throw Exception("Error occurred");
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  //delete portfolio working
  static Future<String> deleteport(int id) async {
    final UserService userService = UserService();

    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.DELETE_PORTFOLIO}");

      var requestBody = {'token': userService.userToken, 'id': id};

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData['message'];
      } else {
        throw Exception('Failed to delete portfolio');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  //rename portfolio working
  static Future<String> renameport(int id, String newname) async {
    final UserService userService = UserService();

    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.REM_PORT}");

      var requestBody = {
        'token': userService.userToken,
        'id': id,
        'newName': newname
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData['message'];
      } else {
        throw Exception('Failed to rename portfolio');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}
