// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_hive_model.dart';
import 'package:uuid/uuid.dart';

part "auth_hive_model.g.dart";

final authHiveModelProvider = Provider<AuthHiveModel>(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? picture;
  @HiveField(3)
  int phone;
  @HiveField(4)
  String email;
  @HiveField(5)
  String password;
  @HiveField(6)
  int? invstyle;
  @HiveField(7)
  int? defaultport;
  @HiveField(8)
  int? userAmount;
  @HiveField(9)
  bool? isAdmin;
  @HiveField(10)
  String token;
  @HiveField(11)
  bool? premium;
  @HiveField(12)
  List<PortfolioHiveModel>? portfolio;

  AuthHiveModel.empty()
      : this(
            userId: '',
            name: '',
            email: '',
            defaultport: 0,
            isAdmin: false,
            password: '',
            phone: 0000000000,
            picture: '',
            userAmount: 0,
            portfolio: [],
            invstyle: 0,
            premium: false);

  AuthHiveModel(
      {required this.name,
      String? userId,
      required this.email,
      required this.defaultport,
      int? invstyle,
      required this.isAdmin,
      required this.password,
      required this.premium,
      required this.phone,
      required this.picture,
      required this.userAmount,
      this.portfolio,
      String? token})
      : userId = userId ?? const Uuid().v4(),
        invstyle = invstyle ?? 0,
        token = token ?? const Uuid().v4();

  factory AuthHiveModel.toHiveModel(AuthEntity authEntity) {
    return AuthHiveModel(
        userId: const Uuid().v4(),
        name: authEntity.name,
        email: authEntity.email,
        defaultport: authEntity.defaultport,
        invstyle: authEntity.invstyle,
        isAdmin: authEntity.isAdmin,
        password: authEntity.password,
        phone: authEntity.phone,
        picture: authEntity.picture,
        premium: authEntity.premium,
        portfolio:
            PortfolioHiveModel.empty().toHiveModelList(authEntity.portfolio!),
        token: const Uuid().v4(),
        userAmount: authEntity.userAmount);
  }

  AuthEntity toEntity(AuthHiveModel authHiveModel) => AuthEntity(
        userid: userId,
        name: name,
        token: token,
        email: email,
        defaultport: defaultport,
        invstyle: invstyle,
        isAdmin: isAdmin,
        password: password,
        phone: phone,
        picture: picture,
        userAmount: userAmount,
      );

  AuthEntity fromEntity(AuthEntity authEntity) => AuthEntity(
        userid: authEntity.userid,
        name: authEntity.name,
        token: authEntity.token,
        email: authEntity.email,
        defaultport: authEntity.defaultport,
        invstyle: authEntity.invstyle,
        isAdmin: authEntity.isAdmin,
        password: authEntity.password,
        phone: authEntity.phone,
        picture: authEntity.picture,
        userAmount: authEntity.userAmount,
      );

  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        name: entity.name,
        email: entity.email,
        defaultport: entity.defaultport,
        invstyle: entity.invstyle,
        isAdmin: entity.isAdmin,
        password: entity.password,
        phone: entity.phone,
        premium: entity.premium,
        picture: entity.picture,
        userAmount: entity.userAmount,
        token: const Uuid().v4(),
      );
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();
}
