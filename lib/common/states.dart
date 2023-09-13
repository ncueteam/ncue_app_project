import 'package:flutter/cupertino.dart';
import '../models/index.dart';
import 'globals.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UserModel extends ProfileChangeNotifier {
  String? get user => _profile.user?.email;

  // APP是否登录(如果有用户信息，则证明登录过)
  //bool get isLogin => user != null;
  bool get isLogin => _profile.token != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  /*void setUser(String email) {
    debugPrint("setuser");
    debugPrint(email);
    if (email != _profile.user?.email) {
      debugPrint("setuser2");
      _profile.lastLogin = email;
      _profile.user?.email = email;
      debugPrint(_profile.user?.email);
      notifyListeners();
    }
  }*/
  void setUser(User user) {
    if (user.email != _profile.user?.email) {
      _profile.lastLogin = user.email;
      _profile.user = user;
      notifyListeners();
    }
  }
  void setToken(String token) {
    if (token != _profile.token) {
      _profile.token = token;
      notifyListeners();
    }
  }
}
