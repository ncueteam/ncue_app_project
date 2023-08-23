import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ncue_aiot/screens/auth_system/login_or_register.dart';

// import 'package:ncue_aiot/screens/webview.dart';
import '../services/local_auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool authenticated = false;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("智慧物聯網系統"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/mqtt'),
            child: const Icon(Icons.account_tree_rounded),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/ble'),
            child: const Icon(Icons.bluetooth),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/database'),
            child: const Icon(Icons.dataset),
          ),
          // PageButton(icon: Icons.abc_sharp, page: WebViewTest())
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/json'),
              child: const Icon(Icons.add_chart),
            ),
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
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/wifi'),
              child: const Icon(Icons.account_circle),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/webview'),
              child: const Icon(Icons.web),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginOrRegisterPage()));
                    break;
                  }
                case 1:
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    break;
                  }
                default:
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    break;
                  }
              }
            },
            tabs: [
              GButton(
                icon: Icons.account_balance,
                text: user!.email!,
              ),
              const GButton(
                icon: Icons.home,
                text: "home",
              ),
              const GButton(
                icon: Icons.settings,
                text: "setting",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
