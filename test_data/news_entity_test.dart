import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/news/domain/entity/news_entity.dart';

Future<List<NewsEntity>> getNewsEntityTest() async {
  final response = await rootBundle.loadString('test_data/news_test_data.json');

  final jsonList = await json.decode(response);

  final List<NewsEntity> newsList =
      jsonList.map<NewsEntity>((json) => NewsEntity.fromJson(json)).toList();

  return Future.value(newsList);
}
