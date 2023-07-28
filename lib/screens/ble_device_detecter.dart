import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../components/page_button.dart';
import 'database.dart';
import 'mqtt.dart';

class BleDeviceList extends StatefulWidget {
  const BleDeviceList({super.key});

  @override
  BleDeviceListState createState() => BleDeviceListState();
}

class BleDeviceListState extends State<StatefulWidget> {
  String debugResult = "none\n";

  // Future<void> turnBleOn() async {
  //   if (await FlutterBluePlus.isAvailable == false) {
  //     setState(() {
  //       debugResult += "Bluetooth not supported by this device";
  //     });
  //     return;
  //   }
  //   if (Platform.isAndroid) {
  //     await FlutterBluePlus.turnOn();
  //   }
  //   await FlutterBluePlus.adapterState
  //       .where((s) => s == BluetoothAdapterState.on)
  //       .first;
  // }

  @override
  void initState() {
    super.initState();
    // turnBleOn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("智慧物聯網系統"),
          centerTitle: true,
          actions: const [
            PageButton(icon: Icons.account_tree_rounded, page: MqttPage()),
            PageButton(icon: Icons.bluetooth, page: BleDeviceList()),
            PageButton(icon: Icons.dataset, page: MysqlDemo()),
          ]),
      body: Column(children: [Text(debugResult)]),
    );
  }
}
