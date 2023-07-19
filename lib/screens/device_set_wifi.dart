import 'package:flutter/material.dart';
import 'package:ncue_aiot/components/page_button.dart';
import 'package:ncue_aiot/screens/home_screen.dart';

class DeviceSetWIFI extends StatelessWidget {
  const DeviceSetWIFI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: const [PageButton(icon: Icons.home, page: HomeScreen())]),
    );
  }
}
