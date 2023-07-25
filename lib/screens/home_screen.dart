import 'package:flutter/material.dart';
import 'package:ncue_aiot/MQTT/MQTTTestPage.dart';
import '../MQTT/MQTTView.dart';
import '../services/local_auth_service.dart';
import 'bt_page.dart';
import 'json_page.dart';
import 'mqtt.dart';
import 'database.dart';
import 'webview.dart';
import 'get_information.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.account_tree_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MQTTTestPage()),
                //MaterialPageRoute(builder: (context) => MqttPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bluetooth),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BTPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.dataset),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MysqlDemo()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JsonScreen()),
                  );
                },
                child: const Icon(Icons.add_chart)
            ),
            ElevatedButton(
                onPressed: () async {
                  final authenticate = await LocalAuth.authenticate();
                  setState(() {
                    authenticated = authenticate;
                  });
                  },
                child: const Icon(Icons.fingerprint)
            ),
            if (authenticated) const Text('You are authenticated'),
            if (authenticated)
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      authenticated = false;
                    });
                  },
                  child: const Text('Log out')
              ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const WebViewTest()),
                  );
                },
                child: const Icon(Icons.web_outlined)
            ),
          ],
        ),
      ),
    );
  }

}