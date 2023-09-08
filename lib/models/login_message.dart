// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'login_message.g.dart';

@JsonSerializable()
class Login_message {
  Login_message();

  late String message;
  late String login_token;

  factory Login_message.fromJson(Map<String, dynamic> json) =>
      _$Login_messageFromJson(json);
  Map<String, dynamic> toJson() => _$Login_messageToJson(this);
}
