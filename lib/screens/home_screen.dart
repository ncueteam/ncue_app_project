import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ncue_aiot/util/smart_device_box.dart';
import '../services/local_auth_service.dart';

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

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  List devices = [
    ["esp32 core", "lib/icons/esp32.png", false],
    ["smart light", "lib/icons/light-bulb.png", true],
    ["smart AC", "lib/icons/air-conditioner.png", false],
    ["smart TV", "lib/icons/smart-tv.png", false],
    ["smart Fan", "lib/icons/fan.png", true],
  ];

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      devices[index][2] = value;
    });
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
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
            itemCount: devices.length,
            padding: const EdgeInsets.all(25),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1 / 1.2),
            itemBuilder: (BuildContext context, int index) {
              return SmartDeviceBox(
                deviceName: devices[index][0],
                iconPath: devices[index][1],
                powerOn: devices[index][2],
                onChanged: (value) => powerSwitchChanged(value, index),
              );
            },
          )),
          Center(
            child: Row(
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user!.email!),
                    ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/ble_page'),
                        child: const Text("藍芽功能分離測試")),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final authenticate = await LocalAuth.authenticate();
                          setState(() {
                            authenticated = authenticate;
                          });
                        },
                        child: const Icon(Icons.fingerprint)),
                    if (authenticated)
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              authenticated = false;
                            });
                          },
                          child: const Text('Log out')),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
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
