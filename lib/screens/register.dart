import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/api_manager.dart';

class RegisterTest extends StatefulWidget {
  const RegisterTest({super.key});

  @override
  State<RegisterTest> createState() => _RegisterTestState();
}

class _RegisterTestState extends State<RegisterTest> {
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
                    TextFormField(
                      controller: emailController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "電子信箱",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: nameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "使用者名稱",
                        prefixIcon: Icon(Icons.people),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "密碼",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "確認密碼",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text("註冊"),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            )));
  }

  void _register() async {
    final UserRepository userRepository = UserRepository();
    var response = await userRepository.register(Register()
      ..email = emailController.text
      ..password = passwordController.text
      ..name = nameController.text);
    debugPrint(response);
  }
}
//{"success":false,"message":"Validation errors","data":{"email":["The email has already been taken."]}}
//201 {"message":"You have successfully registered & logged in!"}