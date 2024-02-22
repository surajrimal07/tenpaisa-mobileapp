import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/toptransaction_entity.dart';

part 'toptransaction_remote_model.g.dart';

@JsonSerializable()
class TopTransactionRemoteModel {
  final String symbol;
  final String name;
  final int transactions;
  final double ltp;

  TopTransactionRemoteModel({
    required this.symbol,
    required this.name,
    required this.transactions,
    required this.ltp,
  });

  factory TopTransactionRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$TopTransactionRemoteModelFromJson(json);
  }

  TopTransactionEntity toEntity() {
    return TopTransactionEntity(
      symbol: symbol,
      name: name,
      transactions: transactions,
      ltp: ltp,
    );
  }
}
