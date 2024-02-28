import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

Future<AuthEntity> getAuthEntityTest() async {
  final response = await rootBundle.loadString('test_data/auth_test_data.json');

  final jsonList = await json.decode(response);

  final AuthEntity indexList =
      jsonList.map<AuthEntity>((json) => AuthEntity.fromJson(json));

  return Future.value(indexList);
}
