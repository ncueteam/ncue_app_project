import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ncue_aiot/components/device_grid_view.dart';
import 'package:ncue_aiot/components/device_unit.dart';
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
          DeviceGridView(
              devices: devices,
              powerSwitchChanged: (bool value, int index) => {
                    setState(() {
                      devices[index][2] = value;
                    })
                  }),
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
                            Navigator.pushNamed(context, '/local_storage'),
                        child: const Text("手機資料儲存測試")),
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
