// import 'package:flutter/material.dart';
// import 'package:sqljocky5/connection/connection.dart';
// import 'package:sqljocky5/results/results.dart';
//
// class mysqlDemo extends StatefulWidget {
//   @override
//   _mysqlDemoState createState() => _mysqlDemoState();
// }
//
// class _mysqlDemoState extends State<mysqlDemo> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     init();
//   }
//
//   //todo:数据库连接
//   late MySqlConnection conn;
//   init() async {
//     print('database connection');
//     var s = ConnectionSettings(
//       user: "root",//todo:用户名
//       password: "",//todo:密码
//       host: "",//todo:flutter中电脑本地的ip
//       port: 1883,//todo:端口
//       db: "flutter_demo",//todo:需要连接的数据库
//     );
//     //todo:获取数据库连接
//     await MySqlConnection.connect(s).then((_){
//       conn=_;
//       print('連接成功');
//     });
//   }
//
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('連接mysql資料庫'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: <Widget>[
//           Wrap(
//             children: <Widget>[
//               ElevatedButton(onPressed:query, child: Text('查詢資料')),
//               ElevatedButton(onPressed:update, child: Text('修改資料')),
//               ElevatedButton(onPressed:delete, child: Text('删除資料')),
//               ElevatedButton(onPressed:insert, child: Text('新增單筆資料')),
//               ElevatedButton(onPressed:insertMuilt, child: Text('新增多筆資料')),
//             ],
//           ),
//           getWidget(_model)
//         ],
//       ),
//     );
//   }
//   String querySql="select name, email from users";
//   //todo:查询数据
//   query() async{
//     _model.clear();
//     Results results = (await conn.execute(querySql)) as Results;
//     print('查询成功');
//     print('${results}');
//     results.forEach((row) {
//       setState(() {
//         model m =model();
//         m.name=row.byName('name');//todo:byName里面放的是你数据库返回的字段名
//         m.email=row.byName('email');
//         _model.add(m);
//       });
//     });
//   }
//   //todo:数据解析
//   List<model> _model =[];
//
//   //todo:获取widget
//   Widget getWidget(List<model> list){
//     List<Widget> _list =[];
//     for(int i=0;i<list.length;i++){
//       _list.add(layout(list[i].name, list[i].email));
//     }
//     return Column(children:_list,);
//   }
//
//   Widget layout(name,email){
//     return Text('Name: ${name}, email: ${email}');
//   }
//
//   //todo:修改数据
//   update() async{
//     await conn.prepared('UPDATE users SET name = ? WHERE id = ?', [
//       '',2
//     ]).then((_){
//       print('${_}');
//     });
//   }
//
//   //todo:新增单条数据
//   insert() async{
//     await conn.prepared('insert into users (name, email) values (?, ?)', ['flutter', 'flutter@qq.com']).then((_){
//       print('新增id${_.insertId}');
//     });
//   }
//
//   //todo:新增多条数据 返回id
//   insertMuilt() async{
//     var results = await conn.preparedWithAll(
//         'insert into users (name, email) values (?, ?)',
//         [['aaa', 'aaa@qq.com'],
//           ['bbb', 'bbb@qq.com'],
//           ['ccc', 'ccc@qq.com']]);
//     print('${results}');
//   }
//
//   //todo:删除数据
//   delete() async{
//     conn.prepared('DELETE FROM users WHERE id = ?', [
//       2
//     ]);
//   }
//
//   //todo:事务操作
//   transaction() async{
//     Transaction trans = await conn.begin();//todo:开启事务
//     try {
//       //todo:如果没有抛出异常就提交事务
//       var result1 = await trans.execute(querySql);
//       var result2 = await trans.execute(querySql);
//       await trans.commit();
//     } catch(e) {
//       //todo:事务回滚
//       await trans.rollback();
//     }
//   }
// }
//
//
// //todo:实体类
// class model{
//   late String name;
//   late String email;
// }
