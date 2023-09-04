import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:ncue_aiot/components/units/UnitGridView.dart';

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

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  List devices = [
    ["account", "yunitrish", "lib/icons/esp32.png", true],
    ["bio_auth"],
    ["page_route", "手機本地存儲", "/local_storage"],
    ["page_route", "藍芽頁面", "/ble_page"],
    [
      "device",
      "b3c477e0-4aef-11ee-be56-0242ac120002",
      "esp32 core",
      "lib/icons/esp32.png",
      false
    ],
    [
      "device",
      "6b92b0fc-4af1-11ee-be56-0242ac120002",
      "smart light",
      "lib/icons/light-bulb.png",
      true
    ],
    [
      "device",
      "75049088-4af1-11ee-be56-0242ac120002",
      "smart AC",
      "lib/icons/air-conditioner.png",
      false
    ],
    [
      "device",
      "7b7dc876-4af1-11ee-be56-0242ac120002",
      "smart TV",
      "lib/icons/smart-tv.png",
      false
    ],
    [
      "device",
      "870ee7c4-4af1-11ee-be56-0242ac120002",
      "smart Fan",
      "lib/icons/fan.png",
      true
    ],
  ];

  @override
  void initState() {
    super.initState();
    if (deviceData.isNotEmpty) {
      deviceData.clear();
    }
    deviceData.put('Devices', devices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("智慧物聯網系統"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: UnitGridView(
            devices: devices,
            powerSwitchChanged: (bool value, int index) => {
                  setState(() {
                    devices[index][2] = value;
                  })
                }),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(14),
            gap: 8,
            onTabChange: (index) {
              switch (index) {
                case 0:
                  {
                    Navigator.pushReplacementNamed(context, '/home');
                    break;
                  }
                case 1:
                  {
                    Navigator.pushNamed(context, '/webview');
                    break;
                  }
                case 2:
                  {
                    Navigator.pushNamed(context, '/database');
                    break;
                  }
                case 3:
                  {
                    Navigator.pushNamed(context, '/json');
                    break;
                  }
                case 4:
                  {
                    Navigator.pushNamed(context, '/mqtt');
                    break;
                  }
                default:
                  {
                    break;
                  }
              }
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "home",
              ),
              GButton(
                icon: Icons.web,
                text: "web",
              ),
              GButton(
                icon: Icons.dataset,
                text: "database",
              ),
              GButton(
                icon: Icons.data_array_sharp,
                text: "json",
              ),
              GButton(
                icon: Icons.account_tree_rounded,
                text: "mqtt",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
