import 'package:flutter/material.dart';
import 'package:ncue_aiot/components/units/biome_auth_unit.dart';
import 'package:ncue_aiot/components/units/device_unit.dart';
import 'package:ncue_aiot/components/units/page_route_unit.dart';

import 'local_auth_unit.dart';

class Unit extends StatefulWidget {
  const Unit({super.key, required this.inputData});
  final List? inputData;

  @override
  State<Unit> createState() => UnitState();
}

class UnitState extends State<Unit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List? data = widget.inputData;
    switch (data?.elementAt(0)) {
      case "device":
        {
          return DeviceUnit(
              deviceName: data?.elementAt(1),
              iconPath: data?.elementAt(2),
              powerOn: data?.elementAt(3),
              onChanged: (bool value) => {});
        }
      case "account":
        {
          return LocalAuthUnit();
        }
      case "bio_auth":
        {
          return const BiomeAuthUnit();
        }
      case "page_route":
        {
          return PageRouteUnit(
              pageName: data?.elementAt(1), pageID: data?.elementAt(2));
        }
      default:
        {
          return const Text("none");
        }
    }
  }
}
