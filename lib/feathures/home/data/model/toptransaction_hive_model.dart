import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/toptransaction_entity.dart';
import 'package:uuid/uuid.dart';

part 'toptransaction_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.topTransactionTableId)
class TopTransactionHiveModel {
  @HiveField(0)
  String topTransactionId;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final int transactions;
  @HiveField(4)
  final double ltp;

  TopTransactionHiveModel({
    String? topTransactionId,
    required this.symbol,
    required this.name,
    required this.transactions,
    required this.ltp,
  }) : topTransactionId = topTransactionId ?? const Uuid().v4();

  factory TopTransactionHiveModel.toHiveModel(TopTransactionHiveModel model) {
    return TopTransactionHiveModel(
      symbol: model.symbol,
      name: model.name,
      transactions: model.transactions,
      ltp: model.ltp,
    );
  }

  TopTransactionHiveModel.empty()
      : symbol = '',
        topTransactionId = '',
        name = '',
        transactions = 0,
        ltp = 0;

  TopTransactionEntity fromEntity(TopTransactionEntity entity) {
    return TopTransactionEntity(
      symbol: entity.symbol,
      name: entity.name,
      transactions: entity.transactions,
      ltp: entity.ltp,
    );
  }

  TopTransactionEntity toEntity() => TopTransactionEntity(
        symbol: symbol,
        name: name,
        transactions: transactions,
        ltp: ltp,
      );

  TopTransactionHiveModel toHiveModel(TopTransactionEntity entity) {
    return TopTransactionHiveModel(
      symbol: entity.symbol,
      name: entity.name,
      transactions: entity.transactions,
      ltp: entity.ltp,
    );
  }

  List<TopTransactionHiveModel> toHiveModelList(
      List<TopTransactionEntity> entity) {
    return entity
        .map((e) => TopTransactionHiveModel(
              symbol: e.symbol,
              name: e.name,
              transactions: e.transactions,
              ltp: e.ltp,
            ))
        .toList();
  }

  List<TopTransactionEntity> toEntityList(
      List<TopTransactionHiveModel> entity) {
    return entity
        .map((e) => TopTransactionEntity(
              symbol: e.symbol,
              name: e.name,
              transactions: e.transactions,
              ltp: e.ltp,
            ))
        .toList();
  }
}
