import 'package:flutter/material.dart';
import 'package:ncue_aiot/components/page_button.dart';
import 'package:ncue_aiot/screens/mqtt.dart';
import '../services/local_auth_service.dart';
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
          PageButton(icon: Icons.home, page: HomeScreen()),
          PageButton(icon: Icons.bluetooth, page: BTPage()),
          PageButton(icon: Icons.dataset, page: MysqlDemo())
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
            if (authenticated) const Text('You are authenticated'),
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
      ),
    );
  }
}
