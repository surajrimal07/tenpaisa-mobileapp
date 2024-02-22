import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';

part 'metals_remote_model.g.dart';

final metalRemoteModelProvider = Provider<MetalRemoteModel>((ref) {
  return MetalRemoteModel(
    unit: '',
    id: '',
    symbol: '',
    name: '',
    category: '',
    sector: '',
    ltp: 0.0,
  );
});

@JsonSerializable()
class MetalRemoteModel {
  MetalRemoteModel({
    required this.unit,
    required this.id,
    required this.symbol,
    required this.name,
    required this.category,
    required this.sector,
    required this.ltp,
  });
  late final String unit;
  @JsonKey(name: '_id')
  late final String id;
  late final String symbol;
  late final String name;
  late final String category;
  late final String sector;
  late final double ltp;

  MetalRemoteModel.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    id = json['_id'];
    symbol = json['symbol'];
    name = json['name'];
    category = json['category'];
    sector = json['sector'];
    ltp = json['ltp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['unit'] = unit;
    data['_id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['category'] = category;
    data['sector'] = sector;
    data['ltp'] = ltp;
    return data;
  }

  MetalsEnity toEntity() => MetalsEnity(
        unit: unit,
        id: id,
        symbol: symbol,
        name: name,
        category: category,
        sector: sector,
        ltp: ltp,
      );

  List<MetalsEnity> toEntityList(List<MetalRemoteModel> list) {
    return list
        .map((item) => MetalsEnity(
              unit: item.unit,
              id: item.id,
              symbol: item.symbol,
              name: item.name,
              category: item.category,
              sector: item.sector,
              ltp: item.ltp,
            ))
        .toList();
  }
}
