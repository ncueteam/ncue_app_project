import 'package:flutter/material.dart';

class PageRouteUnit extends StatelessWidget {
  const PageRouteUnit(
      {super.key, required this.pageName, required this.pageID});
  final String pageName;
  final String pageID;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(100)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, pageID),
              child: Text(pageName))
        ]),
      ),
    );
  }
}
