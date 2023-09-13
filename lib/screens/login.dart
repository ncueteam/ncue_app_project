import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../common/globals.dart';
import '../common/states.dart';
import '../services/local_auth_service.dart';
import 'package:encrypt/encrypt.dart';
import '../services/api_manager.dart';
import '../models/index.dart';
import 'drawer.dart';
//ignore_for_file:use_build_context_synchronously

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
  String loginMessage="";

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
                    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
                    if((v==null||v.trim().isNotEmpty)== false){
                      return "電子信箱不能為空";
                    }else if(RegExp(regexEmail).hasMatch(v!.trim())== false){
                      return "格式錯誤";
                    }else{
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
                  return v==null||v.trim().isNotEmpty ? null : "密碼不能為空";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 55.0),
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: const Text("登入"),
                  ),
                ),
              ),
              Text(loginMessage),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(), //抽屉菜单
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
        if(authenticated){
          const snackBar = SnackBar(
            content: Text('You are authenticated.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Icon(Icons.fingerprint),
    );
  }

  Future<String> encodeString(String content) async{
    final publicKeyStr = await rootBundle.loadString('assets/rsa_public_key.txt');
    debugPrint(publicKeyStr.toString());
    dynamic publicKey = RSAKeyParser().parse(publicKeyStr);
    final encode = Encrypter(RSA(publicKey: publicKey));
    return encode.encrypt(content).base64;
  }

  void _onLogin() async {
    final UserRepository userRepository = UserRepository();
    if ((_formKey.currentState as FormState).validate()) {
      String pwdTemp="";
      await encodeString(_pwdController.text).then((value){
        pwdTemp=value;
      });
      debugPrint(pwdTemp);
      User tempUser=User()..email = _unameController.text
                          ..password = pwdTemp;
      var response=await userRepository.createUser(
          User()..email = _unameController.text
            ..password = pwdTemp
      );
      debugPrint(response);
      //Provider.of<UserModel>(context, listen: false).setUser(_unameController.text);
      Provider.of<UserModel>(context, listen: false).setUser(tempUser);
      debugPrint(Global.profile.user?.email);
      if(response=="400"){
        setState(() {
          loginMessage="帳號密碼錯誤";
        });
      }else{
        setState(() {
          loginMessage="登入成功";
        });
        String tempToken=response.split(" ")[1];
        debugPrint(tempToken);
        Provider.of<UserModel>(context, listen: false).setToken(tempToken);
        //Global.profile.user?.email = _unameController.text;
        debugPrint("continue");
        Navigator.pushReplacementNamed(context, '/webview');
      }
    }
  }
}