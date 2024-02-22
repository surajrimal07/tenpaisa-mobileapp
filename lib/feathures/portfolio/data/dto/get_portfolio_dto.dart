import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_data.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_remote_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

part 'get_portfolio_dto.g.dart';

@JsonSerializable()
class GetPortfolioDTO {
  final List<PortfolioModel> portfolio;
  final PortfolioData portfolioData;
  final bool success;
  final String message;

  GetPortfolioDTO(
      {required this.portfolio,
      required this.portfolioData,
      required this.success,
      required this.message});

  factory GetPortfolioDTO.fromJson(Map<String, dynamic> json) {
    var data = json['data'] as Map<String, dynamic>;

    var portfolioList = (data['portfolio'] as List<dynamic>)
        .map((e) => PortfolioModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return GetPortfolioDTO(
      portfolio: portfolioList,
      portfolioData: PortfolioData.fromJson(data['portfolioData']),
      success: json['success'],
      message: json['message'],
    );
  }

  List<PortfolioEntity> toEntityList() {
    return portfolio.map((item) => item.toEntity()).toList();
  }
}

class PortfolioCombined {
  final List<PortfolioEntity> portfolioEntityList;
  final PortfolioDataEntity portfolioDataEntity;

  PortfolioCombined({
    required this.portfolioEntityList,
    required this.portfolioDataEntity,
  });
}
