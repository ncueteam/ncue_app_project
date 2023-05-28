import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() {
   runApp(
     MaterialApp(
       theme: ThemeData(useMaterial3: true),
       home: MysqlDemo(),
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

  init() async {
    print('database connection');
    await MySqlConnection.connect(ConnectionSettings(
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
              ElevatedButton(onPressed: query, child: const Text('查詢資料')),
              ElevatedButton(onPressed: update, child: const Text('修改資料')),
              ElevatedButton(onPressed: delete, child: const Text('删除資料')),
              ElevatedButton(onPressed: insert, child: const Text('新增單筆資料')),
              ElevatedButton(onPressed: insertMulti, child: const Text('新增多筆資料')),
              ElevatedButton(onPressed: close, child: const Text('關閉資料庫')),
            ],
          ),
          //getWidget(_model)
        ],
      ),
    );
  }

  var conn;

  query() async {
    var results = await conn.query('select * from users2');
    for (var row in results) {
      print('ID: ${row[0]}, Name: ${row[1]}, Join_date: ${row[2]}');
    }
  }

  update() async {

  }

  delete() async {

  }

  insert() async {

  }

  insertMulti() async {

  }

  close() async {
    await conn.close();
  }
}