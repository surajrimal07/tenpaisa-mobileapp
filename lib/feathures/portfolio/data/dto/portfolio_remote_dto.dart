import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_remote_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

part 'portfolio_remote_dto.g.dart';

@JsonSerializable()
class PortfolioRemoteDTO {
  final bool success;
  final String message;
  final List<PortfolioModel> portfolioModel;
  

  PortfolioRemoteDTO({
    required this.success,
    required this.message,
    required this.portfolioModel,
  });

  factory PortfolioRemoteDTO.fromJson(Map<String, dynamic> json) {
    var portfolioListModel = (json['data'] as List<dynamic>)
        .map((e) => PortfolioModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PortfolioRemoteDTO(
      portfolioModel: portfolioListModel,
      success: json['success'],
      message: json['message'],
    );
  }

  List<PortfolioEntity> toEntityList() {
    return portfolioModel.map((item) => item.toEntity()).toList();
  }

  PortfolioRemoteDTO.dummy(this.success, this.message) : portfolioModel = [];
}
