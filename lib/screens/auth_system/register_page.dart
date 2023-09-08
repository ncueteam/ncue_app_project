import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncue_aiot/services/sound_player.dart';

import '../../components/login_button.dart';
import '../../components/square_tile.dart';
import '../../components/styled_text_field.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  final ageController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        addUserDetails(nameController.text.trim(), emailController.text.trim(),
            int.parse(ageController.text.trim()));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        SoundPlayer().playLocalAudio("lib/sounds/crystal.mp3");
      } else {
        Navigator.pop(context);
        wrongMessage("請確認密碼是否正確!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        wrongMessage("無效的電子郵件");
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        wrongMessage("密碼錯誤");
      }
    }
  }

  Future addUserDetails(String name, String email, int age) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'name': name, 'age': age, 'email': email});
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
                    const SizedBox(height: 20),
                    const Icon(Icons.lock, size: 100),
                    const SizedBox(height: 20),
                    Text("創建帳號",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 20.0)),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: emailController,
                      hintText: '電子郵件',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: nameController,
                      hintText: '使用者名稱',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: ageController,
                      hintText: '年齡',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: passwordController,
                      hintText: '密碼',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: confirmPasswordController,
                      hintText: '確認密碼',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    LoginButton(
                      message: "註冊",
                      onTap: signUserUp,
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
                              '或用以下方式註冊',
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
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '已經是會員?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          const Text('現在登入!',
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
