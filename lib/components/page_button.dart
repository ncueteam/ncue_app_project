import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final IconData icon;
  final Widget page;
  final String mode;
  const PageButton(
      {super.key,
      required this.icon,
      required this.page,
      this.mode = "IconButton"});

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case "IconButton":
        {
          return IconButton(
            icon: Icon(icon),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
          );
        }
      case "ElevatedButton":
        {
          return ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => page));
              },
              child: Icon(icon));
        }
      default:
        {
          return IconButton(
            icon: Icon(icon),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
          );
        }
    }
  }
}
