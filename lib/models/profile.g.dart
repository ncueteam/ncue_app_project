// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..email = json['email'] == null
      ? null
      : User.fromJson(json['email'] as Map<String, dynamic>)
  ..password = json['password'] as String?
  ..lastLogin = json['lastLogin'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'lastLogin': instance.lastLogin,
    };
