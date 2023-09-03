import 'package:flutter/material.dart';

import '../../services/local_auth_service.dart';

class BiomeAuthUnit extends StatefulWidget {
  const BiomeAuthUnit({super.key});

  @override
  State<BiomeAuthUnit> createState() => BiomeAuthUnitState();
}

class BiomeAuthUnitState extends State<BiomeAuthUnit> {
  bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(100)),
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
                child: const Icon(Icons.fingerprint)),
            if (authenticated)
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      authenticated = false;
                    });
                  },
                  child: const Text('Log out')),
          ],
        ),
      ),
    );
  }
}
