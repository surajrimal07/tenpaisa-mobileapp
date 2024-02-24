import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/shortterm_entity.dart';

part 'shortterm_interest_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.shortTermInterestTableId)
class ShortTermInterestHiveModel {
  @HiveField(0)
  final Map<String, String> values;

  ShortTermInterestHiveModel({
    required this.values,
  });

  ShortTermInterestHiveModel.empty() : values = Map<String, String>.from({});

  ShortTermInterestHiveModel toHiveModel(ShortTermInterestEntity short) {
    return ShortTermInterestHiveModel(
      values: short.values,
    );
  }

  ShortTermInterestEntity toEntity() {
    return ShortTermInterestEntity(
      values: values,
    );
  }

  ShortTermInterestHiveModel fromEntity(ShortTermInterestEntity short) =>
      ShortTermInterestHiveModel(
        values: short.values,
      );
}
