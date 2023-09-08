// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../common/globals.dart';
import '../common/states.dart';
import '../services/local_auth_service.dart';
import 'package:encrypt/encrypt.dart';
import '../services/api_manager.dart';
import '../models/user.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  LoginRouteState createState() => LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  final GlobalKey _formKey = GlobalKey<FormState>();
  late bool _nameAutoFocus = true;
  bool authenticated = false;
  String loginMessage = "";

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin ?? "";
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("登入")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: const InputDecoration(
                    labelText: "電子信箱",
                    hintText: "電子信箱",
                    prefixIcon: Icon(Icons.email),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    String regexEmail =
                        "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
                    if ((v == null || v.trim().isNotEmpty) == false) {
                      return "電子信箱不能為空";
                    } else if (RegExp(regexEmail).hasMatch(v!.trim()) ==
                        false) {
                      return "格式錯誤";
                    } else {
                      return null;
                    }
                  }),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: "密碼",
                    hintText: "密碼",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v == null || v.trim().isNotEmpty ? null : "密碼不能為空";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 55.0),
                  child: ElevatedButton(
                    // color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    // textColor: Colors.white,
                    child: const Text("登入"),
                  ),
                ),
              ),
              Text(loginMessage),
            ],
          ),
        ),
      ),
      floatingActionButton: _fingerPrinter(),
    );
  }

  Widget _fingerPrinter() {
    return FloatingActionButton(
      onPressed: () async {
        final authenticate = await LocalAuth.authenticate();
        setState(() {
          authenticated = authenticate;
        });
        if (authenticated) {
          const snackBar = SnackBar(
            content: Text('You are authenticated.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Icon(Icons.fingerprint),
    );
  }

  Future<String> encodeString(String content) async {
    final publicKeyStr =
        await rootBundle.loadString('assets/rsa_public_key.txt');
    debugPrint(publicKeyStr.toString());
    dynamic publicKey = RSAKeyParser().parse(publicKeyStr);
    final encode = Encrypter(RSA(publicKey: publicKey));
    return encode.encrypt(content).base64;
  }

  void _onLogin() async {
    final UserRepository userRepository = UserRepository();
    if ((_formKey.currentState as FormState).validate()) {
      debugPrint(_pwdController.text);
      String pwdTemp = "";
      await encodeString(_pwdController.text).then((value) {
        pwdTemp = value;
      });
      debugPrint(pwdTemp);
      var response = await userRepository.createUser(User()
        ..email = _unameController.text
        ..password = pwdTemp);
      if (response == "401") {
        setState(() {
          loginMessage = "帳號密碼錯誤";
        });
      } else {
        setState(() {
          loginMessage = "登入成功";
        });
        Provider.of<UserModel>(context, listen: false).user.email =
            _unameController.text;
      }
    }
  }
}
    // 先验证各个表单字段是否合法
    /*if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User? user;
      try {
        user = await Git(context)
            .login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传入false，这样更新user后便不触发更新。
        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioError catch( e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }
      //登录成功则返回
      if (user != null) {
        Navigator.of(context).pop();
      }
    }*/