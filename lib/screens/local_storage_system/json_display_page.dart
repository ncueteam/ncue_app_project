import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class JsonDisplayPage extends StatefulWidget {
  const JsonDisplayPage({super.key});

  @override
  State<JsonDisplayPage> createState() => JsonDisplayPageState();
}

class JsonDisplayPageState extends State<JsonDisplayPage> {
  final storage = Hive.box('local_storage');
  void writeData() {
    storage.put(1, 'test');

    setState(() {});
  }

  void readData() {
    setState(() {});
  }

  void deleteData() {
    storage.delete(1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: writeData,
              color: Colors.blue[300],
              child: const Text('Write'),
            ),
            MaterialButton(
              onPressed: readData,
              color: Colors.blue[300],
              child: const Text('Read'),
            ),
            MaterialButton(
              onPressed: deleteData,
              color: Colors.blue[300],
              child: const Text('Delete'),
            ),
            Text(storage.get(1).toString())
          ],
        ),
      ),
    );
  }
}
