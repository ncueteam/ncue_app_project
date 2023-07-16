/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import '../screens/database2.dart';

class MysqlController {
    static var conn;
    static bool connectState=false;
    static String _message="";

    static void init() async {
      _message="資料庫初始化...";
      connectState= false;
      //MysqlDemoState().callSetState(_message, connectState);
      debugPrint("資料庫初始化...");
      conn = await MySQLConnection.createConnection(
        host: "frp.4hotel.tw",
        port: 25583,
        userName: "app_user2",
        password: "0000",
        databaseName: "app_data", // optional
      );
      await conn.connect();
      debugPrint("Connected");
      _message="Connected";
      connectState= true;
      //MysqlDemoState().callSetState(_message, connectState);
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
    static connect() async {
      _message="資料庫初始化...";
      //MysqlDemoState().callSetState(_message, connectState);
      debugPrint("資料庫初始化...");
      conn = await MySQLConnection.createConnection(
        host: "frp.4hotel.tw",
        port: 25583,
        userName: "app_user2",
        password: "0000",
        databaseName: "app_data", // optional
      );
      await conn.connect();
      debugPrint("Connected");
      _message="Connected";
      connectState= true;
      //MysqlDemoState().callSetState(_message, connectState);
    }

    static query() async {
      var results = await conn.execute('SELECT * FROM users2');
      for (final row in results.rows) {
        _message+="${row.assoc()}\n";
        debugPrint(row.assoc().toString());
        //MysqlDemoState().callSetState(_message, connectState);
      }
    }

    static update() async {
      var res = await conn.execute(
        "UPDATE users2 SET name=:name, join_date=:date WHERE name='adam'",
        {"name": "Adam","date":"2023-06-05"},
      );
      if(res.affectedRows.toString()=="0"){
        debugPrint("該資料不存在");
        _message="該資料不存在";
        //MysqlDemoState().callSetState(_message, connectState);
      }
      else {
        debugPrint("修改成功 AffectedRows: ${res.affectedRows}");
        _message="修改成功 AffectedRows: ${res.affectedRows}";
        //MysqlDemoState().callSetState(_message, connectState);
      }
    }

    static delete() async {
      var res = await conn.execute(
          "DELETE FROM users2 WHERE name='Vivian'"
      );
      if(res.affectedRows.toString()=="0"){
        debugPrint("該資料不存在");
        _message="該資料不存在";
        //MysqlDemoState().callSetState(_message, connectState);
      }
      else {
        debugPrint("刪除成功 AffectedRows: ${res.affectedRows}");
        _message="刪除成功 AffectedRows: ${res.affectedRows}";
        //MysqlDemoState().callSetState(_message, connectState);
      }
    }

    static insert() async {
      var res = await conn.execute(
        "INSERT INTO users2 (name, join_date) VALUES (:name, :join_date)",
        {
          "name": "Vivian",
          "join_date": "2022-02-02",
        },
      );
      if(res.affectedRows.toString()=="0"){
        debugPrint("新增失敗");
        _message="新增失敗";
        //MysqlDemoState().callSetState(_message, connectState);
      }
      else {
        debugPrint("新增成功 AffectedRows: ${res.affectedRows}");
        _message="新增成功 AffectedRows: ${res.affectedRows}";
        //MysqlDemoState().callSetState(_message, connectState);
      }
    }

    static close() async {
      await conn.close();
      _message="資料庫已關閉";
      connectState= false;
      //MysqlDemoState().callSetState(_message, connectState);
      debugPrint("資料庫已關閉");
    }
}*/