// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'toptransaction_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopTransactionRemoteModel _$TopTransactionRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TopTransactionRemoteModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      transactions: json['transactions'] as int,
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$TopTransactionRemoteModelToJson(
        TopTransactionRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'transactions': instance.transactions,
      'ltp': instance.ltp,
    };
