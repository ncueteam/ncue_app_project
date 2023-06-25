import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class MysqlController {
    static var conn;
    static bool connectState=false;
    static String _message="";
    /*getMessage(){
      return _message;
    }
    setMessage(String a){
      _message=a;
    }*/
    static void init() {
      setState(() {
        _message="資料庫初始化...";
        connectState= false;
      });
      conn= MySQLConnection.createConnection(
        host: "frp.4hotel.tw",
        port: 25583,
        userName: "app_user2",
        password: "0000",
        databaseName: "app_data", // optional
      );
      conn.connect();
      debugPrint("Connected");
      setState(() {
        _message="Connected";
        connectState= true;
      });
    }
    /*Future<void> init() async {
      this.conn= await MySQLConnection.createConnection(
      host: "frp.4hotel.tw",
      port: 25583,
      userName: "app_user2",
      password: "0000",
      databaseName: "app_data", // optional
      );
      await conn.connect();

      debugPrint("Connected");
      _message="Connected";
    }*/
    query() async {
      var results = await conn.execute('SELECT * FROM users2');
      for (final row in results.rows) {
        _message+="${row.assoc()}\n";
        debugPrint(row.assoc().toString());
        setState(() {
          _message=_message;
        });
      }
    }
}