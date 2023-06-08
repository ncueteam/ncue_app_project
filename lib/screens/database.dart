import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class MysqlDemo extends StatefulWidget {
  const MysqlDemo({Key? key}) : super(key: key);

  @override
  MysqlDemoState createState() => MysqlDemoState();
}

class MysqlDemoState extends State<MysqlDemo> {

  @override
  void initState() {
    super.initState();
    init();
  }

  String _message="";
  var conn;
  init() async {
    _message="資料庫初始化...";
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
  }

  @override
  void dispose() {
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
              ElevatedButton(onPressed: close, child: const Text('關閉資料庫')),
              Text(_message)
            ],
          ),
        ],
      ),
    );
  }

  query() async {
    var results = await conn.execute('SELECT * FROM users2');
    for (final row in results.rows) {
      //_message=row.assoc();
      print(row.assoc());
    }
  }

  createTable() async {
    debugPrint(conn.toString());
    var results = await conn.execute(
        'CREATE TABLE ex_table (id INT NOT NULL AUTO_INCREMENT,name VARCHAR(255) NOT NULL,PRIMARY KEY (id))');
    if (results.affectedRows != null && results.affectedRows > 0) {
      debugPrint("資料表已成功建立");
    } else {
      debugPrint("建立資料表時發生錯誤");
    }
  }

  update() async {
    var res = await conn.execute(
      "UPDATE users2 SET name=:name, join_date=:date WHERE name='Adam'",
      {"name": "adam","date":"2023-06-05"},
    );

    print(res.affectedRows);
  }

  delete() async {
    var res = await conn.execute(
        "DELETE FROM users2 WHERE name='Vivian'"
    );
  }

  insert() async {
    var res = await conn.execute(
      "INSERT INTO users2 (name, join_date) VALUES (:name, :join_date)",
      {
        "name": "Vivian",
        "join_date": "2022-02-02",
      },
      /*{
        "name": "Zoe",
        "join_date": "2023-02-02",
      },*/
    );

    print(res.affectedRows);
  }

  close() async {
    await conn.close();
    _message="資料庫已關閉";
    debugPrint("資料庫已關閉");
  }
}
