import 'package:flutter/material.dart';

import '../services/local_auth_service.dart';
import 'mqtt.dart';

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
      ),
      body: Center(
        child: Column(
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
            if (authenticated)
              ElevatedButton(
                child: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
            if (authenticated)
              ElevatedButton(
                child: const Icon(Icons.account_tree_rounded),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MqttPage()),
                  );
                },
              ),

          ],
        ),
      ),
    );
  }

}