// import 'package:paisa/feathures/home/data/model/metals_remote_model.dart';

// class MetalsRemoteDTO {
//   List<MetalRemoteModel> metalPrices;

//   MetalsRemoteDTO({required this.metalPrices});

//   MetalsRemoteDTO.fromJson(Map<String, dynamic> json)
//       : metalPrices = List<MetalRemoteModel>.from(
//           json['metalPrices']?.map((v) => MetalRemoteModel.fromJson(v)) ?? [],
//         );

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['metalPrices'] = metalPrices.map((v) => v.toJson()).toList();
//     return data;
//   }
// }

import 'package:paisa/feathures/home/data/model/metals_remote_model.dart';

class MetalDTO {
  MetalDTO({
    required this.metalPrices,
  });
  late final List<MetalRemoteModel> metalPrices;

  MetalDTO.fromJson(Map<String, dynamic> json) {
    metalPrices = List.from(json['metalPrices'])
        .map((e) => MetalRemoteModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['metalPrices'] = metalPrices.map((e) => e.toJson()).toList();
    return data;
  }
}
