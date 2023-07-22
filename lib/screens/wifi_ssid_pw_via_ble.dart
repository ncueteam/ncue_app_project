import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_blue_plus/flutter_blue_plus.dart";

class WifiSetter extends StatefulWidget {
  const WifiSetter({Key? key}) : super(key: key);

  @override
  _WifiSetterState createState() => _WifiSetterState();
}

class _WifiSetterState extends State<WifiSetter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WifiSetter"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  //controller: wifiNameController,
                  decoration: InputDecoration(labelText: 'Wifi Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  //controller: wifiPasswordController,
                  decoration: InputDecoration(labelText: 'Wifi Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  //onPressed: submitAction,
                  onPressed:() {},
                  //color: Colors.indigoAccent,
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ));
  }
}
