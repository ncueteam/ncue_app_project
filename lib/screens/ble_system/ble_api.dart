import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

String prettyException(String prefix, dynamic e) {
  if (e is FlutterBluePlusException) {
    // ignore: deprecated_member_use
    return "$prefix ${e.errorString}";
  } else if (e is PlatformException) {
    return "$prefix ${e.message}";
  } else {
    return prefix + e.toString();
  }
}
