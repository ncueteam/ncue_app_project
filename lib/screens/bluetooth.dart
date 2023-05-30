import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  BluetoothPageState createState() => BluetoothPageState();
}
class BluetoothPageState extends State<BluetoothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late BluetoothDevice selectedDevice;
  late BluetoothCharacteristic selectedCharacteristic;
  late bool on = false;
  List<ScanResult> scanResults = []; // List to store scan results

  @override
  void initState() {
    super.initState();
    flutterBlue.state.listen((state) {
      if (state == BluetoothState.on) {
        scanDevices();
      }
    });
  }

  void scanDevices() {
    scanResults = [];
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results; // Update scan results
      });
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    // List<BluetoothService> services = await device.discoverServices();
    setState(() {
      selectedDevice = device;
      on = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BT Device list'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: scanDevices,
            child: const Text('Scan Device'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: scanResults.length,
            itemBuilder: (context, index) {
              final result = scanResults[index];
              return ListTile(
                title: Text(result.device.name),
                subtitle: Text(result.device.id.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
