import 'package:flutter/material.dart';

import 'device_unit.dart';

// ignore: must_be_immutable
class DeviceGridView extends StatelessWidget {
  DeviceGridView(
      {super.key, required this.devices, required this.powerSwitchChanged});

  final List devices;
  void Function(bool, int)? powerSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      itemCount: devices.length,
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.2),
      itemBuilder: (BuildContext context, int index) {
        return DeviceUnit(
          deviceName: devices[index][0],
          iconPath: devices[index][1],
          powerOn: devices[index][2],
          onChanged: (value) => powerSwitchChanged!(value, index),
        );
      },
    ));
  }
}
