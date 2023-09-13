import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/states.dart';
import 'login.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // 移除顶部 padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(), //构建抽屉菜单头部
            Expanded(child: _buildMenus()), //构建功能菜单
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget? child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                Text(
                  value.isLogin
                      ? value.user.toString()
                      : "登入",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginRoute()),);
            }
          },
        );
      },
    );
  }

  Widget _buildMenus(){
    return SwitchListTile(
      title: const Text('指紋辨識快速登入'),
      value: false,
      onChanged: (bool value) {
      },
      secondary: const Icon(Icons.fingerprint),
    );
  }
}