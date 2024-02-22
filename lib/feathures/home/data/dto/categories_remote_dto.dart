import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/categories_remote_model.dart';
import 'package:paisa/feathures/home/data/model/dataversion_remote_model.dart';

part 'categories_remote_dto.g.dart';

@JsonSerializable()
class CategoriesDataDTO {
  final TopCategoriesRemoteModel data;
  final bool isFallback;
  final bool isCached;
  final DataVersionModel dataversion;

  CategoriesDataDTO({
    required this.data,
    required this.isFallback,
    required this.isCached,
    required this.dataversion,
  });

  factory CategoriesDataDTO.fromJson(Map<String, dynamic> json) {
    return CategoriesDataDTO(
      data: TopCategoriesRemoteModel.fromJson(json['data']),
      isFallback: json['isFallback'],
      isCached: json['isCached'],
      dataversion: DataVersionModel.fromJson(json['dataversion']),
    );
  }
}
