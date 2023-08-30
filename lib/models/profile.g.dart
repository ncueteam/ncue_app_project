// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..token = json['token'] as String?
  ..lastLogin = json['lastLogin'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'lastLogin': instance.lastLogin,
    };
