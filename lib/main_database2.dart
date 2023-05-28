import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
//import 'dart:async';
// ignore_for_file: avoid_print

void main() {
  runApp(
    MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home:  MysqlDemo(),
    ),
  );
}

class MysqlDemo extends StatefulWidget {
  @override
  _MysqlDemoState createState() => _MysqlDemoState();
}

class _MysqlDemoState extends State<MysqlDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  var conn;
  init() async {
    print('database connection');
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'frp.4hotel.tw',
        port: 25582,
        user: 'root',
        db: 'app_data',
        password: ''));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('連接mysql資料庫'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              ElevatedButton(onPressed:query, child: const Text('查詢資料')),
              ElevatedButton(onPressed:update, child: const Text('修改資料')),
              ElevatedButton(onPressed:delete, child: const Text('删除資料')),
              ElevatedButton(onPressed:insert, child: const Text('新增單筆資料')),
              ElevatedButton(onPressed:insertMulti, child: const Text('新增多筆資料')),
              ElevatedButton(onPressed:close, child: const Text('關閉資料庫')),
            ],
          ),
          //getWidget(_model)
        ],
      ),
    );
  }

  //todo:查询数据
  query() async{
    var results = await conn.query("select name, join_date from users2");
    for (var row in results) {
      print('Name: ${row[0]}, email: ${row[1]}');
    }
  }

  //todo:修改数据
  update() async{
    await conn.query(
        'update users set age=? where name=?',
        ['2023-01-01', 'ann']);
  }

//todo:刪除数据
  delete() async{
    var results = await conn.query('DELETE FROM users2 WHERE id = ?', [2]);
    for (var row in results) {
      print('Name: ${row[0]}, email: ${row[1]}');
    }
  }

//todo:新增单条数据
  insert() async{
    var result = await conn.query('insert into users2 (name, join_date) values (?, ?)', ['Bob', '2023-05-27']);
    print("New user's id: ${result.insertId}");
  }

//todo:新增多条数据
  insertMulti() async{
    var results = await conn.query.queryMulti(
        'insert into users (name, join_date) values (?, ?)',
        [['Nina', '2021-09-13'],
          ['Bill', '2022-05-11'],
          ['Joe', '2022-06-20']]);
    for (var row in results) {
      print('Name: ${row[0]}, email: ${row[1]}');
    }
  }
  close() async{
    await conn.close();
    print("database close");
  }
}




