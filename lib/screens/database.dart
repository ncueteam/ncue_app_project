import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MysqlDemo extends StatefulWidget {
  const MysqlDemo({Key? key}) : super(key: key);

  @override
  MysqlDemoState createState() => MysqlDemoState();
}

class MysqlDemoState extends State<MysqlDemo> {
  late MySqlConnection conn;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    debugPrint("資料庫初始化...");
    var settings = ConnectionSettings(
      host: 'frp.4hotel.tw',
      port: 25583,
      user: 'user',
      db: 'app_data',
      password: '0000',
    );

    conn = await MySqlConnection.connect(settings);
  }

  @override
  void dispose() {
    conn.close();
    debugPrint("資料庫已關閉");
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
          Column(
            children: <Widget>[
              ElevatedButton(onPressed: query, child: const Text('查詢資料')),
              ElevatedButton(onPressed: update, child: const Text('修改資料')),
              ElevatedButton(onPressed: delete, child: const Text('删除資料')),
              ElevatedButton(onPressed: insert, child: const Text('新增單筆資料')),
              ElevatedButton(onPressed: createTable, child: const Text('新增資料表')),
              ElevatedButton(onPressed: insertMulti, child: const Text('新增多筆資料')),
              ElevatedButton(onPressed: close, child: const Text('關閉資料庫')),
            ],
          ),
        ],
      ),
    );
  }

  query() async {
    var results = await conn.query('select * from users2');
    for (var row in results) {
      debugPrint('ID: ${row[0]}, Name: ${row[1]}, Join_date: ${row[2]}');
    }
  }

  createTable() async {
    if (conn == null) return;
    var results = await conn.query('''
      CREATE TABLE ex_table (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        PRIMARY KEY (id)
      )
    ''');
    if (results.affectedRows != null && results.affectedRows! > 0) {
      debugPrint("資料表已成功建立");
    } else {
      debugPrint("建立資料表時發生錯誤");
    }
  }

  update() async {}

  delete() async {}

  insert() async {}

  insertMulti() async {}

  close() async {
    await conn.close();
    debugPrint("資料庫已關閉");
  }
}
