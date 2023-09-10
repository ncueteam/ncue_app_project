import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../models/index.dart';
import 'package:http/http.dart' as http;

abstract class ApiDataSource {
  /// Create new user.
  Future<String> createUser(User body);

  /// Get user info id, username, passowrd
  Future<String> getUser(int id);

  /// Update user data
  Future<String> updateUser(int id, User body);
}

class UserRepository implements ApiDataSource {
  final client = http.Client();
  final String domain = "http://frp.4hotel.tw:25580/api";
  String xsrf = "";

  Future getXsrf() async {
    try {
      debugPrint("debug print3");
      Uri url = Uri.parse("http://frp.4hotel.tw:25580/sanctum/csrf-cookie");
      http.Response response = await http.get(url);
      if (response.statusCode == 204) {
        debugPrint(response.statusCode.toString());
        String setCookieHeader = response.headers['set-cookie']!;
        xsrf = setCookieHeader.split("XSRF-TOKEN=")[1];
        xsrf = xsrf.split(" ")[0];
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed in fetch xsrf');
    }
  }

  Future<String> register(Register body) {
    return _register(
      Uri.parse('$domain/register'),
      body,
    );
  }
  Future<String> _register(
      Uri url,
      Register body,
      ) async {
    try {
      await getXsrf();
      debugPrint("debug print5");
      debugPrint(body.toJson().toString());

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "X-XSRF-TOKEN": xsrf,
          "credentials": 'include',
          "Accept": 'application/json',
        },
        body: json.encode(body.toJson()),
      );
      if (response.statusCode == 200) {   //成功
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        response.body.split('"')[7];
        var tempToken= response.body.split('"')[7];
        debugPrint("tempToken: $tempToken");
        return "${response.statusCode} $tempToken";
      } else {   //400 不存在
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        return response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> createUser(User body) {
    return _login(
      Uri.parse('$domain/login'),
      body,
    );
  }
  Future<String> _login(
      Uri url,
      User body,
      ) async {
    try {
      await getXsrf();
      debugPrint("debug print5");
      debugPrint(body.toJson().toString());

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "X-XSRF-TOKEN": xsrf,
          "credentials": 'include',
          "Accept": 'application/json',
        },
        body: json.encode(body.toJson()),
      );
      if (response.statusCode == 200) {   //成功
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        response.body.split('"')[7];
        var tempToken= response.body.split('"')[7];
        debugPrint("tempToken: $tempToken");
        return "${response.statusCode} $tempToken";
      } else {   //400 不存在
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        return response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> getUser(id) {
    return _getUser(
      Uri.parse('$domain/auth/$id'),
    );
  }

  Future<String> _getUser(
    Uri url,
  ) async {
    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log(
          response.body,
          name: response.statusCode.toString(),
        );
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> updateUser(int id, User body) {
    return _updateUser(
      Uri.parse('$domain/auth/$id'),
      body,
    );
  }

  Future<String> _updateUser(
    Uri url,
    User body,
  ) async {
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body.toJson(),
      );
      if (response.statusCode == 200) {
        log(
          response.body,
          name: response.statusCode.toString(),
        );
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
