//add Equatable too
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

part 'auth_entity.g.dart';

final authEntityProvider = StateProvider<AuthEntity>((ref) => const AuthEntity(
    name: DefaultUserValues.defaultName,
    email: DefaultUserValues.defaultEmail,
    password: DefaultUserValues.defaultPassword,
    token: DefaultUserValues.defaultToken,
    wallets: DefaultUserValues.defaultWallets,
    phone: DefaultUserValues.defaultPhone));

@JsonSerializable()
class AuthEntity extends Equatable {
  final String? userid;
  final String name;
  final String? picture;
  final int phone;
  final String email;
  final String password;
  final int? invstyle;
  final int? defaultport;
  final int? userAmount;
  final bool? isAdmin;
  final bool? premium;
  final String token;
  final List<PortfolioEntity>? portfolio;
  final int? wallets;

  @override
  List<Object?> get props => [
        userid,
        name,
        picture,
        phone,
        email,
        password,
        invstyle,
        defaultport,
        userAmount,
        isAdmin,
        premium,
        token,
        portfolio,
        wallets
      ];

  factory AuthEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthEntityToJson(this);

  const AuthEntity(
      {required this.name,
      this.userid,
      required this.email,
      int? defaultport,
      this.invstyle,
      bool? isAdmin,
      this.premium,
      required this.password,
      required this.phone,
      String? picture,
      required this.token,
      this.portfolio,
      this.wallets,
      int? userAmount})
      : picture = picture ?? AppStrings.defaultPicture,
        userAmount = userAmount ?? AppStrings.defaultAmount,
        defaultport = defaultport ?? AppStrings.defaultPort,
        isAdmin = isAdmin ?? AppStrings.defaultIsAdmin;

  //dummy
  static const dummy = AuthEntity(
      name: DefaultUserValues.defaultName,
      email: DefaultUserValues.defaultEmail,
      password: DefaultUserValues.defaultPassword,
      token: DefaultUserValues.defaultToken,
      phone: DefaultUserValues.defaultPhone);
} // if isadmin false, defaultport, amount, profile

//test to update value later,

