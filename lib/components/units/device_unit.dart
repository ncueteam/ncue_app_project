import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceUnit extends StatefulWidget {
  DeviceUnit({super.key, required this.deviceData, required this.onChanged});

  void Function(bool)? onChanged;
  final List deviceData;

  @override
  State<DeviceUnit> createState() => _DeviceUnitState();
}

class _DeviceUnitState extends State<DeviceUnit> {
  late String deviceName;
  late String deviceUUID;
  late String iconPath;
  late bool powerOn;

  Future updateDeviceData() async {
    CollectionReference devices =
        FirebaseFirestore.instance.collection('devices');
    QuerySnapshot querySnapshot =
        await devices.where('uuid', isEqualTo: deviceUUID).get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      DocumentReference documentReference = devices.doc(documentSnapshot.id);

      Map<String, dynamic> updatedData = {
        'uuid': deviceUUID,
        'device_name': deviceName,
        'iconPath': iconPath,
        'powerOn': powerOn,
      };
      await documentReference.update(updatedData);
    } else {
      await FirebaseFirestore.instance.collection('devices').add({
        'uuid': deviceUUID,
        'device_name': deviceName,
        'iconPath': iconPath,
        'powerOn': powerOn
      });
    }
  }

  @override
  void initState() {
    super.initState();
    deviceUUID = widget.deviceData.elementAt(1);
    deviceName = widget.deviceData.elementAt(2);
    iconPath = widget.deviceData.elementAt(3);
    // ignore: sdk_version_since
    powerOn = bool.parse(widget.deviceData.elementAt(4).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
            color: powerOn ? Colors.grey[350] : Colors.grey[700],
            borderRadius: BorderRadius.circular(24)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(iconPath,
                  height: 65, color: powerOn ? Colors.black : Colors.white),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      deviceName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: powerOn ? Colors.black : Colors.white),
                    ),
                  )),
                  Transform.rotate(
                      angle: pi / 2,
                      child: Switch(
                        value: powerOn,
                        onChanged: (bool value) => {
                          setState(
                            () {
                              powerOn = value;
                              widget.onChanged;
                              updateDeviceData();
                            },
                          )
                        },
                      ))
                ],
              )
            ]),
      ),
    );
  }
}
