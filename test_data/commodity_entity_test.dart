import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

Future<List<CommodityEntity>> getCommodityEntityTest() async {
  final response =
      await rootBundle.loadString('test_data/commodity_test_data.json');

  final jsonList = await json.decode(response);

  final List<CommodityEntity> commodityList = jsonList
      .map<CommodityEntity>((json) => CommodityEntity.fromJson(json))
      .toList();

  return Future.value(commodityList);
}
