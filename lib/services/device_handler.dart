import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:uuid/uuid.dart';

class DeviceHandler {
  static FirebaseFirestore database = FirebaseFirestore.instance;

  static Future<void> loadDevices(List devices) async {
    database.collection('devices').get().then((querySnapshot) => {
          for (var docSnapshot in querySnapshot.docs)
            {
              devices.addOrUpdate([
                docSnapshot.get('type'),
                docSnapshot.get('uuid'),
                docSnapshot.get('device_name'),
                docSnapshot.get('iconPath'),
                docSnapshot.get('powerOn')
              ])
            }
        });
  }

  static Future<void> addDevice(
      String type, String deviceName, String iconPath, bool powerOn) async {
    database.collection('devices').add({
      "type": type,
      "uuid": const Uuid().v1().toString(),
      "device_name": deviceName,
      "iconPath": iconPath,
      "powerOn": powerOn,
    });
  }
}
