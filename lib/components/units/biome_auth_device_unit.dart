import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/local_auth_service.dart';

// ignore: must_be_immutable
class BioAuthDeviceUnit extends StatefulWidget {
  BioAuthDeviceUnit(
      {super.key, required this.deviceData, required this.onChanged});

  void Function(bool)? onChanged;
  final List deviceData;

  @override
  State<BioAuthDeviceUnit> createState() => BioAuthDeviceUnitState();
}

class BioAuthDeviceUnitState extends State<BioAuthDeviceUnit> {
  bool authenticated = false;
  late String deviceName;
  late String deviceUUID;
  late String iconPath;
  late bool powerOn;

  Widget authDeviceButton() {
    if (authenticated) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(iconPath,
            height: 40, color: powerOn ? Colors.black : Colors.white),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
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
                )),
          ],
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                authenticated = false;
              });
            },
            child: const Text('Log out'))
      ]);
    } else {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                deviceName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: powerOn ? Colors.black : Colors.white),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final authenticate = await LocalAuth.authenticate();
                  setState(() {
                    authenticated = authenticate;
                  });
                },
                child: const Icon(Icons.fingerprint)),
          ],
        ),
      );
    }
  }

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
    powerOn = widget.deviceData.elementAt(4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: powerOn ? Colors.grey[350] : Colors.grey[700],
            borderRadius: BorderRadius.circular(24)),
        child: authDeviceButton(),
      ),
    );
  }
}
