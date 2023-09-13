// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register()
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..password = json['password'] as String?;

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
