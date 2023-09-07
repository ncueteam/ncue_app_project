import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncue_aiot/services/soundPlayer.dart';

import '../../components/login_button.dart';
import '../../components/square_tile.dart';
import '../../components/styled_text_field.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      SoundPlayer().playLocalAudio("lib/sounds/crystal.mp3");
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        wrongMessage("查無此帳號");
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        wrongMessage("密碼錯誤");
      }
    }
  }

  wrongMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(message),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Icon(Icons.lock, size: 100),
                    const SizedBox(height: 50),
                    Text("歡迎使用本系統", style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: emailController,
                      hintText: '使用者名稱',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: passwordController,
                      hintText: '密碼',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '忘記密碼?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    LoginButton(
                      message: "登入",
                      onTap: signUserIn,
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 5,
                            color: Colors.grey[400],
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '或用以下方式登入',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 5,
                            color: Colors.grey[400],
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                            onTap: () => AuthService().signInWithGoogle(),
                            imagePath: 'lib/icons/google.png'),
                        const SizedBox(width: 25),
                        SquareTile(
                            onTap: () {}, imagePath: 'lib/icons/apple.png')
                      ],
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '還不是會員?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          const Text('現在註冊!',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
