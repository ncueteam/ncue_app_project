import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
  
  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      
      return await _auth.authenticate(
        localizedReason: 'Use Face If to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true
        )
      );
    } catch (e) {
      debugPrint('error $e');
      return false;
    }
  }
} 