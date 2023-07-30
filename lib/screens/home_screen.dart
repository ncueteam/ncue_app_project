import 'package:flutter/material.dart';
import 'package:ncue_aiot/components/page_button.dart';
import 'package:ncue_aiot/screens/mqtt.dart';
import 'package:ncue_aiot/screens/wifi_ssid_pw_via_ble.dart';
// import 'package:ncue_aiot/screens/webview.dart';
import '../services/local_auth_service.dart';
import 'ble_device_detecter.dart';
import 'bt_page.dart';
import 'json_page.dart';
import 'database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool authenticated = false;

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
          // PageButton(icon: Icons.abc_sharp, page: WebViewTest())
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PageButton(
              icon: Icons.addchart,
              page: JsonScreen(),
              mode: "ElevatedButton",
            ),
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
            const PageButton(
              icon: Icons.account_circle,
              page: WifiSetter(),
              mode: "ElevatedButton",
            ),
          ],
        ),
      ),
    );
  }
}
