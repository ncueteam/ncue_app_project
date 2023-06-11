import 'package:flutter/material.dart';
import 'package:ncue_aiot/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'MQTT/MQTTAppState.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NCUE 彰師大物聯網',
      theme: ThemeData(
        primaryColorDark: Colors.black12,
        primaryColorLight: Colors.white60,
        primarySwatch: Colors.blueGrey
      ),
      home: const HomeScreen()
    );
  }
}

