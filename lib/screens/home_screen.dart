import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ncue_aiot/components/units/unit_grid_view.dart';

import '../components/route_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool authenticated = false;
  final deviceData = Hive.box('local_storage');
  Future<void>? _dataLoadingFuture;

  List devices = [
    ["account", "yunitrish", "lib/icons/esp32.png", true],
    ["page_route", "手機本地存儲", "/local_storage"],
    ["page_route", "藍芽頁面", "/ble_page"],
    ["page_route", "apple", "/apple_test"]
  ];

  List deviceID = [];

  Future<void> refreshHandler() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  Future loadDevices() async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    database.collection('devices').get().then((querySnapshot) => {
          for (var docSnapshot in querySnapshot.docs)
            {
              devices.add([
                // docSnapshot.get('type'),
                "bio_auth_device",
                docSnapshot.get('uuid'),
                docSnapshot.get('device_name'),
                docSnapshot.get('iconPath'),
                docSnapshot.get('powerOn')
              ])
            }
        });
  }

  Future loadUnits() async {
    if (deviceData.isNotEmpty) {
      deviceData.clear();
    }
    _dataLoadingFuture = loadDevices();
    await _dataLoadingFuture;
    deviceData.put('Devices', devices);
  }

  @override
  void initState() {
    super.initState();
    loadUnits();
    setState(() {});
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
      ),
      bottomNavigationBar: const RouteNavigationBar(),
    );
  }
}
