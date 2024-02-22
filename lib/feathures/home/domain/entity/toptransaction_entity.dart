import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toptransaction_entity.g.dart';

final topTransactionProvider = StateProvider<TopTransactionEntity>((ref) {
  return const TopTransactionEntity(
      symbol: 'Null', name: 'Null', ltp: 0.0, transactions: 0);
});

@JsonSerializable()
class TopTransactionEntity extends Equatable {
  final String symbol;
  final String name;
  final double ltp;
  final int transactions;

  const TopTransactionEntity(
      {required this.symbol,
      required this.name,
      required this.ltp,
      required this.transactions});

  @override
  List<Object?> get props => [symbol, name, ltp, transactions];

  factory TopTransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TopTransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TopTransactionEntityToJson(this);

  TopTransactionEntity toEntity() => TopTransactionEntity(
        symbol: symbol,
        name: name,
        ltp: ltp,
        transactions: transactions,
      );
}
