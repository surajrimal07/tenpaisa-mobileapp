import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/nrb_data_local_model.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

final nrbCacheProvider = Provider<NrbCache>((ref) {
  return NrbCache(
      hiveService: ref.read(hiveServiceProvider),
      nrbDataLocalHiveModel: ref.read(nrbDataLocalHiveModelProvider));
});

class NrbCache {
  final HiveService hiveService;
  final NrbDataLocalHiveModel nrbDataLocalHiveModel;

  NrbCache({required this.hiveService, required this.nrbDataLocalHiveModel});

  Future<void> addNrbData(NrbDataEntity nrbData) async {
    await hiveService
        .addNrbDataMarketData(nrbDataLocalHiveModel.toHiveModel(nrbData));
  }
}
