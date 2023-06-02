import 'package:flutter/material.dart';

import '../services/local_auth_service.dart';
import 'bluetooth.dart';
import 'database.dart';
import 'mqtt.dart';
import 'google.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool authenticated = false;

  List<Widget> authButton(bool auth) {
    if (auth) {
      List<Widget> widgets = [
        const Text('指紋辨識'),
        const Text('You are authenticated'),
        ElevatedButton(
            onPressed: () {
              setState(() {
                authenticated = false;
              });
            },
            child: const Text('Log out')
        )
      ];
      return widgets;
    }
    else {
      List<Widget> widgets = [
        const Text('指紋辨識'),
        ElevatedButton(
          onPressed: () async {
            final authenticate = await LocalAuth.authenticate();
            setState(() {
              authenticated = authenticate;
            });
          },
          child: const Icon(Icons.fingerprint)
        )
      ];
      return widgets;
    }
  }

  List<Widget> actionBarButtons() {
    List<Widget> widgets = [
      IconButton(
        icon: const Icon(Icons.account_tree_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MqttPage()),
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
            MaterialPageRoute(builder: (context) => const BluetoothPage()),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.add_box),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MysqlDemo()),
          );
        },
      ),
    ];
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("智慧物聯網系統"),
        centerTitle: true,
        actions: actionBarButtons()
      ),
      body: Center(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: authButton(authenticated),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('網頁嵌入'),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WebPage(url: "https://www.google.com/")),
                      );
                    },
                    child: const Icon(Icons.web)
                )
              ],
            ),
          ],
        )
      ),
    );
  }

}