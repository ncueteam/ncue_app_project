import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
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

  @override
  Future<String> createUser(User body) {
    return _createUser(
      Uri.parse('$domain/login'),
      body,
    );
  }

  Future<String> _createUser(
      Uri url,
      User body,
      ) async {
    try {
      final response = await client.post(
        url,
        body: body.toJson(),
      );
      if (response.statusCode == 201) {
        debugPrint("debug print1");
        log(
          response.body,
          name: response.statusCode.toString(),
        );
        return response.body;
      } else {
        debugPrint("debug print2");
        debugPrint(response.body);
        return response.body;
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