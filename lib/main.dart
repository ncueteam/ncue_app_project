import 'package:flutter/material.dart';
import 'package:ncue_aiot/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (Platform.isAndroid) {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   [
  //     Permission.location,
  //     Permission.storage,
  //     Permission.bluetooth,
  //     Permission.bluetoothConnect,
  //     Permission.bluetoothScan
  //   ].request().then((status) {
  //     runApp(const Main());
  //   });
  // } else {
  runApp(const Main());
  // }
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
          primarySwatch: Colors.blueGrey),
      home: const HomeScreen(),
    );
  }
}
