import 'package:flutter/material.dart';

class DeviceSetWIFI extends StatelessWidget {
  const DeviceSetWIFI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/home'),
          child: const Icon(Icons.home),
        ),
      ]),
    );
  }
}
