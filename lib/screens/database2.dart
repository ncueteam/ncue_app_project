/*import 'package:flutter/material.dart';
import '../services/mysql_service.dart';

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
    //MysqlController.init();
    //callSetState(_message, connectState);
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
              ElevatedButton(onPressed: connectState ? null : MysqlController.connect(), child: const Text('連接資料庫')),
              ElevatedButton(onPressed: connectState ? MysqlController.query() : null, child: const Text('查詢資料')),
              ElevatedButton(onPressed: connectState ? MysqlController.insert() : null, child: const Text('新增資料')),
              ElevatedButton(onPressed: connectState ? MysqlController.update() : null, child: const Text('修改資料')),
              ElevatedButton(onPressed: connectState ? MysqlController.delete() : null, child: const Text('删除資料')),
              ElevatedButton(onPressed: connectState ? MysqlController.close() : null, child: const Text('關閉資料庫')),
              Text(_message, style:const TextStyle(fontSize: 20))
              //],
              //),
            ],
          ),
        ],
      ),
    );
  }
  /*void callSetState(String message,bool state){
    setState(() {
      _message=message;
      connectState= state;
    });
  }*/
}*/
