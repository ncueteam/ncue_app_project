import 'package:flutter/material.dart';

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
          title: const Text("WifiSetter"),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                //controller: wifiNameController,
                decoration: InputDecoration(labelText: 'Wifi Name'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                //controller: wifiPasswordController,
                decoration: InputDecoration(labelText: 'Wifi Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                //onPressed: submitAction,
                onPressed: () {},
                //color: Colors.indigoAccent,
                child: const Text('Submit'),
              ),
            )
          ],
        ));
  }
}
