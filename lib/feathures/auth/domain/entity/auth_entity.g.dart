// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthEntity _$AuthEntityFromJson(Map<String, dynamic> json) => AuthEntity(
      name: json['name'] as String,
      userid: json['userid'] as String?,
      email: json['email'] as String,
      defaultport: json['defaultport'] as int?,
      invstyle: json['invstyle'] as int?,
      isAdmin: json['isAdmin'] as bool?,
      premium: json['premium'] as bool?,
      password: json['password'] as String,
      phone: json['phone'] as int,
      picture: json['picture'] as String?,
      token: json['token'] as String,
      portfolio: (json['portfolio'] as List<dynamic>?)
          ?.map((e) => PortfolioEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallets: json['wallets'] as int?,
      userAmount: json['userAmount'] as int?,
    );

Map<String, dynamic> _$AuthEntityToJson(AuthEntity instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'name': instance.name,
      'picture': instance.picture,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'invstyle': instance.invstyle,
      'defaultport': instance.defaultport,
      'userAmount': instance.userAmount,
      'isAdmin': instance.isAdmin,
      'premium': instance.premium,
      'token': instance.token,
      'portfolio': instance.portfolio,
      'wallets': instance.wallets,
    };
