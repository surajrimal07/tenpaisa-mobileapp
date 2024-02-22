// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toptransaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopTransactionEntity _$TopTransactionEntityFromJson(
        Map<String, dynamic> json) =>
    TopTransactionEntity(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      transactions: json['transactions'] as int,
    );

Map<String, dynamic> _$TopTransactionEntityToJson(
        TopTransactionEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'ltp': instance.ltp,
      'transactions': instance.transactions,
    };
