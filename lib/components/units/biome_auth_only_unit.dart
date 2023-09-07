import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/local_auth_service.dart';

// ignore: must_be_immutable
class BiomeAuthUnit extends StatefulWidget {
  BiomeAuthUnit({super.key, required this.deviceData, required this.onChanged});

  void Function(bool)? onChanged;
  final List deviceData;

  @override
  State<BiomeAuthUnit> createState() => BiomeAuthUnitState();
}

class BiomeAuthUnitState extends State<BiomeAuthUnit> {
  bool authenticated = false;

  Widget authButton() {
    if (authenticated) {
      List data = widget.deviceData;
      data.removeAt(0);
      debugPrint(data.toString());
      return const Text('Log out');
    } else {
      return ElevatedButton(
          onPressed: () async {
            final authenticate = await LocalAuth.authenticate();
            setState(() {
              authenticated = authenticate;
            });
          },
          child: const Icon(Icons.fingerprint));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(color: context.theme.primaryColor, width: 6),
              borderRadius: BorderRadius.circular(100)),
          child: FittedBox(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: authButton(),
          ))),
    );
  }
}
