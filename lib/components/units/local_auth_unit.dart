import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocalAuthUnit extends StatelessWidget {
  LocalAuthUnit({super.key});
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(100)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Expanded(
              child: Text(
            "帳號資料",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          )),
          Expanded(
              child: Text(
            user!.displayName!,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          )),
        ]),
      ),
    );
  }
}
