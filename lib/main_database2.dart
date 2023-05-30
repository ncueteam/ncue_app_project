/*import 'package:mysql1/mysql1.dart';

Future main() async {
  final conn = await MySqlConnection.connect(
    ConnectionSettings(
      host: 'frp.4hotel.tw',
      port: 25580,
      user: 'root',
      password: '',
      db: 'app_data',
    ),
  );

  //查询操作
  var results = await conn.query('select * from user2');
  for (var row in results) {
    print('name: ${row[0]}, age: ${row[1]}, gender: ${row[2]}');
  }

  //插入操作
  /*var insertResult = await conn.query(
      'insert into user (name, age, gender) values (?, ?, ?)',
      ['张三', 18, '男']);
  print('insert ${insertResult.affectedRows} row');

  //更新操作
  var updateResult = await conn.query(
      'update user set gender = ? where age > ?',
      ['女', 18]);
  print('update ${updateResult.affectedRows} row');

  //删除操作
  var deleteResult = await conn.query(
      'delete from user where age < ?',
      [18]);
  print('delete ${deleteResult.affectedRows} row');*/
  await conn.close();
}*/



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

  var conn;
  init() async {
    print('database connection');
    await MySqlConnection.connect(ConnectionSettings(
        host: 'frp.4hotel.tw', //'','10.0.2.2'
        port: 3306,//25580
        user: 'app_user',
        db: 'app_data',
        password: '0000'));

    await MySqlConnection.connect(conn).then((_){
       conn=_;
       print('連接成功');
     });
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

