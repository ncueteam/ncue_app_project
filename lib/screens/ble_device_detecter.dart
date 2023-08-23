import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleDeviceList extends StatefulWidget {
  const BleDeviceList({super.key});

  @override
  BleDeviceListState createState() => BleDeviceListState();
}

class BleDeviceListState extends State<StatefulWidget> {
  String debugResult = "none\n";

  bleOn() async {
    FlutterBluePlus.setLogLevel(LogLevel.verbose);
    // check availability
    if (await FlutterBluePlus.isAvailable == false) {
      setState(() {
        debugResult += "Bluetooth not supported by this device";
      });
      return;
    }

    // turn on bluetooth ourself if we can
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
      setState(() {
        debugResult += "FlutterBluePlus.turnOn()\n";
      });
    }

    // wait bluetooth to be on
    await FlutterBluePlus.adapterState
        .where((s) => s == BluetoothAdapterState.on)
        .first;
    setState(() {
      debugResult += "BluetoothAdapterState is on!\n";
    });
  }

  scanDevices() async {
    // ignore: unused_local_variable
    StreamSubscription<List<ScanResult>> subscription =
        FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        setState(() {
          debugResult += '${r.device.localName} found! rssi: ${r.rssi}';
        });
      }
    });

    // Start scanning
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    // Stop scanning
    await FlutterBluePlus.stopScan();
    setState(() {
      debugResult += "scan finished";
    });
  }

  @override
  void initState() {
    super.initState();
    bleOn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("智慧物聯網系統"), centerTitle: true, actions: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/mqtt'),
          child: const Icon(Icons.account_tree_rounded),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/ble'),
          child: const Icon(Icons.bluetooth),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/database'),
          child: const Icon(Icons.dataset),
        ),
      ]),
      body: Center(
        child: Column(children: [
          Text(debugResult),
          ElevatedButton(
              onPressed: () => {scanDevices()}, child: const Text("scan"))
        ]),
      ),
    );
  }
}
