import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:ncue_aiot/services/mysql_service.dart';

class MysqlDemo extends StatefulWidget {
  const MysqlDemo({Key? key}) : super(key: key);

  @override
  MysqlDemoState createState() => MysqlDemoState();
}

class MysqlDemoState extends State<MysqlDemo> {

  late MysqlController controller=MysqlController.init();
  @override
  void initState() {
    //controller.init();
    super.initState();
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
              ElevatedButton(onPressed: controller.query(), child: const Text('查詢資料')),
              Text(controller.getMessage())
            ],
          ),
        ],
      ),
    );
  }
}
