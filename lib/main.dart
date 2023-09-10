import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ncueapp/screens/auth_system/apple_test.dart';
import 'package:ncueapp/screens/auth_system/firebase_auth_page.dart';
import 'package:ncueapp/screens/auth_system/login_or_register.dart';
import 'package:ncueapp/screens/ble_device_detecter.dart';
import 'package:ncueapp/screens/database.dart';
import 'package:ncueapp/screens/json_page.dart';
import 'package:ncueapp/screens/local_storage_system/json_display_page.dart';
import 'package:ncueapp/screens/mqtt.dart';
import 'package:ncueapp/screens/webview.dart';
import 'package:provider/provider.dart';

import 'bluetooth/flutter_blue_plus/wifisetter.dart';
import 'common/globals.dart';
import 'common/states.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('local_storage');

  Global.init().then((e) => runApp(const Main()));
  //runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserModel()),
        ],
        builder: (BuildContext context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NCUE 彰師大物聯網',
            theme: ThemeData(
                primaryColorDark: Colors.black12,
                primaryColorLight: Colors.white60,
                primarySwatch: Colors.blueGrey),
            home: const AuthPage(),
            routes: {
              '/home': (context) => const AuthPage(),
              '/mqtt': (context) => const MqttPage(),
              '/json': (context) => const JsonScreen(),
              '/login': (context) => const LoginOrRegisterPage(),
              '/database': (context) => const MysqlDemo(),
              '/webview': (context) => const WebViewTest(),
              '/ble': (context) => const BleDeviceList(),
              '/ble_page': (context) => const FlutterBlueApp(),
              '/local_storage': (context) => const JsonDisplayPage(),
              '/apple_test': (context) => const AppleTest(),
            },
          );
        });
  }
}
