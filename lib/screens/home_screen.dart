import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ncue_aiot/components/units/unit_grid_view.dart';

import '../services/device_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final deviceData = Hive.box('local_storage');

  List units = [
    ["account", "yunitrish", "lib/icons/esp32.png", true],
    ["page_route", "手機本地存儲", "/local_storage"],
    ["page_route", "藍芽頁面", "/ble_page"],
    ["page_route", "apple", "/apple"],
    ["page_route", "網頁", "/webview"],
    ["page_route", "資料庫", "/database"],
    ["page_route", "Json", "/json"],
    ["page_route", "MQTT", "/mqtt"],
  ];

  Future loadUnits() async {
    if (deviceData.isNotEmpty) {
      deviceData.clear();
    }
    await DeviceHandler.loadDevices();
    units.addAll(DeviceHandler.devices);
    deviceData.put('Devices', units);
  }

  @override
  void initState() {
    loadUnits();
    setState(() {});
    super.initState();
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
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () => {
                      DeviceHandler.addDevice(
                          "device", "added", "lib/icons/fan.png", false)
                    },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () => {Navigator.popAndPushNamed(context, '/home')},
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () => {FirebaseAuth.instance.signOut()},
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: const Column(
          children: [
            UnitGridView(),
          ],
        ));
  }
}
