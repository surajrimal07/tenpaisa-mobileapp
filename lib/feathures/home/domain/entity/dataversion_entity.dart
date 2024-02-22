import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dataversion_entity.g.dart';

//create a state provider for this entity
final dataVersionProvider = StateProvider<DataVersionEntiy>((ref) {
  return const DataVersionEntiy(version: 'Null', date: '');
});

@JsonSerializable()
class DataVersionEntiy extends Equatable {
  final String version;
  final String date;

  const DataVersionEntiy({required this.version, required this.date});

  @override
  List<Object?> get props => [version, date];

  factory DataVersionEntiy.fromJson(Map<String, dynamic> json) =>
      _$DataVersionEntiyFromJson(json);
}
