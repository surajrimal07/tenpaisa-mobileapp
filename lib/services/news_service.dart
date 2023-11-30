import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class News {
  static Future<List<dynamic>> fetchNews() async {
    var url = Uri.parse('${ServerConfig.SERVER_ADDRESS}${ServerConfig.NEWS}');

    const String cacheKey = 'news_cache';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<dynamic> data = json.decode(cachedData);
        return data;
      }

      print("Fetching news");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        prefs.setString(cacheKey, response.body);
        return json.decode(response.body);
      } else {
        CustomToast.showToast("Failed to load news");
        return [];
      }
    } catch (error) {
      CustomToast.showToast('Error fetching data: $error');
      return [];
    }
  }
}
