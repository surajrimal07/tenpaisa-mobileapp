import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_remote_model.dart';

part 'auth_remote_model.g.dart';

@JsonSerializable()
class AuthRemoteModel {
  @JsonKey(name: '_id')
  final String? userid;
  final String name;
  @JsonKey(name: 'dpImage')
  final String? picture;
  final int phone;
  final String email;
  final String pass;
  @JsonKey(name: 'style')
  final int? invstyle;
  int? defaultport;
  final List<PortfolioModel> portfolio;
  final int? userAmount;
  final bool? isAdmin;
  final String token;
  final bool? premium;
  final int? wallets;

  AuthRemoteModel(
      {this.userid,
      required this.name,
      this.picture,
      required this.phone,
      required this.email,
      required this.pass,
      this.invstyle,
      this.defaultport,
      this.userAmount,
      required this.portfolio,
      required this.token,
      this.premium,
      this.wallets,
      this.isAdmin});

  factory AuthRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$AuthRemoteModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthRemoteModelToJson(this);
  }

  factory AuthRemoteModel.fromEntity(AuthEntity entity) {
    return AuthRemoteModel(
      name: entity.name,
      picture: entity.picture,
      phone: entity.phone,
      email: entity.email,
      pass: entity.password,
      invstyle: entity.invstyle,
      defaultport: entity.defaultport,
      premium: entity.premium,
      userAmount: entity.userAmount,
      token: entity.token,
      isAdmin: entity.isAdmin, //added
      wallets: entity.wallets, //added later
      portfolio: List<PortfolioModel>.from(entity.portfolio ?? []),
    );
  }

  static AuthEntity toEntity(AuthRemoteModel model) {
    return AuthEntity(
      userid: model.userid ?? "",
      userAmount: model.userAmount,
      defaultport: model.defaultport,
      isAdmin: model.isAdmin,
      name: model.name,
      picture: model.picture,
      phone: model.phone,
      email: model.email,
      premium: model.premium,
      password: model.pass,
      invstyle: model.invstyle,
      token: model.token,
      wallets: model.wallets,
      portfolio:
          model.portfolio.map((portfolio) => portfolio.toEntity()).toList(),
    );
  }
}
