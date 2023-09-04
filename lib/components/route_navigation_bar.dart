import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RouteNavigationBar extends StatelessWidget {
  const RouteNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: const EdgeInsets.all(14),
          gap: 8,
          onTabChange: (index) {
            switch (index) {
              case 0:
                {
                  Navigator.pushNamed(context, '/home');
                  break;
                }
              case 1:
                {
                  Navigator.pushNamed(context, '/webview');
                  break;
                }
              case 2:
                {
                  Navigator.pushNamed(context, '/database');
                  break;
                }
              case 3:
                {
                  Navigator.pushNamed(context, '/json');
                  break;
                }
              case 4:
                {
                  Navigator.pushNamed(context, '/mqtt');
                  break;
                }
              default:
                {
                  break;
                }
            }
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "home",
            ),
            GButton(
              icon: Icons.web,
              text: "web",
            ),
            GButton(
              icon: Icons.dataset,
              text: "database",
            ),
            GButton(
              icon: Icons.data_array_sharp,
              text: "json",
            ),
            GButton(
              icon: Icons.account_tree_rounded,
              text: "mqtt",
            ),
          ],
        ),
      ),
    );
  }
}
