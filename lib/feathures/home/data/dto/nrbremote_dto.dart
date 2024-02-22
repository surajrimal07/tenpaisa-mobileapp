import 'package:paisa/feathures/home/data/model/nrb_data_remote_model.dart';

class NrbRemoteDTO {
  bool success;
  String message;
  NrbRemoteDataModel data;

  NrbRemoteDTO(
      {required this.success, required this.message, required this.data});

  factory NrbRemoteDTO.fromJson(Map<String, dynamic> json) {
    return NrbRemoteDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: NrbRemoteDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
