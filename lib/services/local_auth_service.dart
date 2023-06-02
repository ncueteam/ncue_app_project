import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async {
    try {
      debugPrint('device checking...');
      bool canCheckBio = await _auth.canCheckBiometrics;
      bool support = await _auth.isDeviceSupported();
      debugPrint('device:( bio: $canCheckBio, support: $support)');
      return canCheckBio && support;
    } catch (e) {
      debugPrint('Error checking biometrics: $e');
      return false;
    }
  }

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      debugPrint('use checking biometrics...');
      return await _auth.authenticate(
        localizedReason: 'Use Face ID to authenticate',
      );
    } catch (e) {
      debugPrint('Authentication error: $e');
      return false;
    }
  }
}
