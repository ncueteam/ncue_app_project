import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmartDeviceBox extends StatelessWidget {
  SmartDeviceBox(
      {super.key,
      required this.deviceName,
      required this.iconPath,
      required this.powerOn,
      required this.onChanged});

  void Function(bool)? onChanged;
  final String deviceName;
  final String iconPath;
  final bool powerOn;

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
                    padding: const EdgeInsets.only(left: 25.0),
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
                      child: Switch(value: powerOn, onChanged: onChanged))
                ],
              )
            ]),
      ),
    );
  }
}
