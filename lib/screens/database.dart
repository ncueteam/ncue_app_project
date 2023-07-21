import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class MysqlDemo extends StatefulWidget {
  const MysqlDemo({Key? key}) : super(key: key);

  @override
  MysqlDemoState createState() => MysqlDemoState();
}

class MysqlDemoState extends State<MysqlDemo> {
  String _message = "";
  List<String> logs = [];
  bool connectState = false;

  MySQLConnection? connection;
  final userNameField = TextEditingController();

  List<Widget> buttons = [];

  void updateButtons() {
    buttons.clear();
    buttons.addAll([
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            width: 180,
            child: TextField(
                controller: userNameField,
                decoration:
                    const InputDecoration(hintText: '使用者名稱 (User Name)'),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => {}),
          )),
      ElevatedButton(
          onPressed: connectState ? null : connect, child: const Text('連接資料庫')),
      ElevatedButton(
          onPressed: connectState ? query : null, child: const Text('查詢資料')),
      ElevatedButton(
          onPressed: connectState ? () => {insert(userNameField.text)} : null,
          child: const Text('新增資料')),
      ElevatedButton(
          onPressed: connectState ? () => {update(userNameField.text)} : null,
          child: const Text('修改資料')),
      ElevatedButton(
          onPressed: connectState ? () => {delete(userNameField.text)} : null,
          child: const Text('删除資料')),
      ElevatedButton(
          onPressed: connectState ? close : null, child: const Text('關閉資料庫')),
      Text(_message, style: const TextStyle(fontSize: 20))
    ]);
    for (String line in logs) {
      buttons.add(Text(line));
    }
  }

  @override
  void initState() {
    super.initState();
    connect();
    updateButtons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateButtons();
    return Scaffold(
      appBar: AppBar(
        title: const Text('連接mysql資料庫'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: buttons,
          ),
        ],
      ),
    );
  }

  connect() async {
    setState(() {
      logs.add("連線至資料庫...");
    });
    connection = await MySQLConnection.createConnection(
      host: "frp.4hotel.tw",
      port: 25583,
      userName: "app_user2",
      password: "0000",
      databaseName: "app_data",
    );
    await connection?.connect();
    setState(() {
      logs.add("已連線");
      connectState = true;
    });
  }

  void query() async {
    IResultSet? results = await connection?.execute('SELECT * FROM users2');
    for (final row in results!.rows) {
      setState(() {
        logs.add(row.assoc().toString());
      });
    }
  }

  void update(String name) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    IResultSet? res = await connection?.execute(
      "UPDATE users2 SET name=:name, join_date=:date WHERE name='$name'",
      {"name": name, "date": date},
    );
    if (res!.affectedRows.toString() == "0") {
      setState(() {
        logs.add("該資料不存在");
      });
    } else {
      setState(() {
        logs.add("修改成功 AffectedRows: ${res.affectedRows}");
      });
    }
  }

  void delete(String name) async {
    IResultSet? res =
        await connection?.execute("DELETE FROM users2 WHERE name='$name'");
    if (res!.affectedRows.toString() == "0") {
      setState(() {
        logs.add("該資料不存在");
      });
    } else {
      setState(() {
        logs.add("刪除成功 AffectedRows: ${res.affectedRows}");
      });
    }
  }

  void insert(String name) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    IResultSet? res = await connection?.execute(
      "INSERT INTO users2 (name, join_date) VALUES (:name, :join_date)",
      {
        "name": name,
        "join_date": date,
      },
    );
    if (res!.affectedRows.toString() == "0") {
      setState(() {
        logs.add("新增失敗");
      });
    } else {
      setState(() {
        logs.add("新增成功 AffectedRows: ${res.affectedRows}");
      });
    }
  }

  close() async {
    await connection?.close();
    setState(() {
      _message = "資料庫已關閉";
      connectState = false;
    });
    debugPrint("資料庫已關閉");
  }
}
