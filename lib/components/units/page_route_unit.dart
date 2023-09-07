import 'package:flutter/material.dart';

class PageRouteUnit extends StatelessWidget {
  const PageRouteUnit(
      {super.key, required this.pageName, required this.pageID});
  final String pageName;
  final String pageID;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          border: Border.all(color: Theme.of(context).primaryColor, width: 6),
          borderRadius: BorderRadius.circular(180),
        ),
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, pageID),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              pageName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
