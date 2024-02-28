import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

Future<List<StockEntity>> getStockEntityTest() async {
  final response =
      await rootBundle.loadString('test_data/stock_test_data.json');

  final jsonList = await json.decode(response);

  final List<StockEntity> portfolioList =
      jsonList.map<StockEntity>((json) => StockEntity.fromJson(json)).toList();

  return Future.value(portfolioList);
}
