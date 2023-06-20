import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class MysqlDemo extends StatefulWidget {
  const MysqlDemo({Key? key}) : super(key: key);

  @override
  MysqlDemoState createState() => MysqlDemoState();
}

class MysqlDemoState extends State<MysqlDemo> {

  String _message="";
  bool connectState=false;
  @override
  void initState() {
    super.initState();
    init();
  }

  var conn;
  init() async {
    setState(() {
      _message="資料庫初始化...";
      connectState= false;
    });
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
    setState(() {
      _message="Connected";
      connectState= true;
    });
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
              //Expanded(children: <Widget>[
                ElevatedButton(onPressed: connectState ? null : connect, child: const Text('連接資料庫')),
                ElevatedButton(onPressed: connectState ? query : null, child: const Text('查詢資料')),
                ElevatedButton(onPressed: connectState ? insert : null, child: const Text('新增資料')),
                ElevatedButton(onPressed: connectState ? update : null, child: const Text('修改資料')),
                ElevatedButton(onPressed: connectState ? delete : null, child: const Text('删除資料')),
                ElevatedButton(onPressed: connectState ? close : null, child: const Text('關閉資料庫')),
                Text(_message, style:const TextStyle(fontSize: 20))
                //],
              //),
            ],
          ),
        ],
      ),
    );
  }

  connect() async {
    setState(() {
      _message="資料庫初始化...";
    });
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
    setState(() {
      _message="Connected";
      connectState= true;
    });
  }

  query() async {
    _message="";
    var results = await conn.execute('SELECT * FROM users2');
    for (final row in results.rows) {
      _message+="${row.assoc()}\n";
      debugPrint(row.assoc().toString());
      setState(() {
        _message=_message;
      });
    }
  }

  update() async {
    var res = await conn.execute(
      "UPDATE users2 SET name=:name, join_date=:date WHERE name='adam'",
      {"name": "Adam","date":"2023-06-05"},
    );
    if(res.affectedRows.toString()=="0"){
      debugPrint("該資料不存在");
      setState(() {
        _message="該資料不存在";
      });
    }
    else {
      debugPrint("修改成功 AffectedRows: ${res.affectedRows}");
      setState(() {
        _message="修改成功 AffectedRows: ${res.affectedRows}";
      });
    }
  }

  delete() async {
    var res = await conn.execute(
        "DELETE FROM users2 WHERE name='Vivian'"
    );
    if(res.affectedRows.toString()=="0"){
      debugPrint("該資料不存在");
      setState(() {
        _message="該資料不存在";
      });
    }
    else {
      debugPrint("刪除成功 AffectedRows: ${res.affectedRows}");
      setState(() {
        _message="刪除成功 AffectedRows: ${res.affectedRows}";
      });
    }
  }

  insert() async {
    var res = await conn.execute(
      "INSERT INTO users2 (name, join_date) VALUES (:name, :join_date)",
      {
        "name": "Vivian",
        "join_date": "2022-02-02",
      },
    );
    if(res.affectedRows.toString()=="0"){
      debugPrint("新增失敗");
      setState(() {
        _message="新增失敗";
      });
    }
    else {
      debugPrint("新增成功 AffectedRows: ${res.affectedRows}");
      setState(() {
        _message="新增成功 AffectedRows: ${res.affectedRows}";
      });
    }
  }

  close() async {
    await conn.close();
    setState(() {
      _message="資料庫已關閉";
      connectState= false;
    });
    debugPrint("資料庫已關閉");
  }
}
