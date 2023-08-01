import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ncue_aiot/bluetooth/views/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bluetooth_data.dart';
import 'controllers/device_controller.dart';
import 'controllers/global_controller.dart';

DateTime? currentBackPressTime;
late Controller ctrl;
late ScrollController listScrollController;
late SharedPreferences prefs;

class WifiSetter extends StatefulWidget {
  const WifiSetter({Key? key}) : super(key: key);

  @override
  WifiSetterState createState() => WifiSetterState();
}

class WifiSetterState extends State<WifiSetter>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    ctrl.initTabController(this);
    init();

    listScrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listScrollController.hasClients) {
        listScrollController.animateTo(
            listScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    BluetoothData.instance.dispose();
    listScrollController.dispose();
    super.dispose();
  }

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    // load the saved device list
    DeviceController.loadDeviceListFromStorage();
    await BluetoothData.instance.initBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus
            ?.unfocus(), // to hide keyboard if the screen tapped outside of the keyboard
        child: const MainView());
  }
}
