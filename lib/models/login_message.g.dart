// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login_message _$Login_messageFromJson(Map<String, dynamic> json) =>
    Login_message()
      ..message = json['message'] as String
      ..login_token = json['login_token'] as String;

Map<String, dynamic> _$Login_messageToJson(Login_message instance) =>
    <String, dynamic>{
      'message': instance.message,
      'login_token': instance.login_token,
    };
