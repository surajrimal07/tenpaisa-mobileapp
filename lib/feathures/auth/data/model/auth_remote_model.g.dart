// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRemoteModel _$AuthRemoteModelFromJson(Map<String, dynamic> json) =>
    AuthRemoteModel(
      userid: json['_id'] as String?,
      name: json['name'] as String,
      picture: json['dpImage'] as String?,
      phone: json['phone'] as int,
      email: json['email'] as String,
      pass: json['pass'] as String,
      invstyle: json['style'] as int?,
      defaultport: json['defaultport'] as int?,
      userAmount: json['userAmount'] as int?,
      portfolio: (json['portfolio'] as List<dynamic>)
          .map((e) => PortfolioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String,
      premium: json['premium'] as bool?,
      wallets: json['wallets'] as int?,
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$AuthRemoteModelToJson(AuthRemoteModel instance) =>
    <String, dynamic>{
      '_id': instance.userid,
      'name': instance.name,
      'dpImage': instance.picture,
      'phone': instance.phone,
      'email': instance.email,
      'pass': instance.pass,
      'style': instance.invstyle,
      'defaultport': instance.defaultport,
      'portfolio': instance.portfolio,
      'userAmount': instance.userAmount,
      'isAdmin': instance.isAdmin,
      'token': instance.token,
      'premium': instance.premium,
      'wallets': instance.wallets,
    };
