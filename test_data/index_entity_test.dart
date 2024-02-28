import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

Future<List<IndexEntity>> getIndexEntityTest() async {
  final response = await rootBundle.loadString('test_data/index_test.json');

  final jsonList = await json.decode(response);

  final List<IndexEntity> indexList =
      jsonList.map<IndexEntity>((json) => IndexEntity.fromJson(json)).toList();

  return Future.value(indexList);
}
