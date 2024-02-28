import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

Future<List<WatchlistEntity>> getWatchlistEntityTest() async {
  final response =
      await rootBundle.loadString('test_data/watchlist_test_data.json');

  final jsonList = await json.decode(response);

  final List<WatchlistEntity> watchlistList = jsonList
      .map<WatchlistEntity>((json) => WatchlistEntity.fromJson(json))
      .toList();

  return Future.value(watchlistList);
}
