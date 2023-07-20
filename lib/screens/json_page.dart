import 'dart:convert';
import 'package:flutter/material.dart';

class JsonScreen extends StatefulWidget {
  const JsonScreen({Key? key}) : super(key: key);

  @override
  State<JsonScreen> createState() {
    return JsonScreenState();
  }
}

class JsonScreenState extends State<JsonScreen> {
  bool authenticated = false;
  String jsonString = '';
  Map<String, dynamic> jsonMap = {};

  void parseJsonData() {
    setState(() {
      try {
        jsonMap = json.decode(jsonString);
      } catch (e) {
        // print('Invalid JSON data: $e');
      }
    });
  }

  String getValueFromJson(String key) {
    if (jsonMap.containsKey(key)) {
      return jsonMap[key].toString();
    } else {
      return 'Key not found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Json example")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Enter JSON data',
              ),
              onChanged: (value) {
                setState(() {
                  jsonString = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              parseJsonData();
            },
            child: const Text('Parse JSON'),
          ),
          ElevatedButton(
            onPressed: () {
              String name = getValueFromJson('name');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Name'),
                    content: Text(name),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Show Name'),
          ),
          ElevatedButton(
            onPressed: () {
              String age = getValueFromJson('age');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Age'),
                    content: Text(age),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Show Age'),
          ),
          ElevatedButton(
            onPressed: () {
              String address = getValueFromJson('address');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Address'),
                    content: Text(address),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Show Address'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              enabled: false,
              controller: TextEditingController(
                text: getValueFromJson('name'),
              ),
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              enabled: false,
              controller: TextEditingController(
                text: getValueFromJson('age'),
              ),
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              enabled: false,
              controller: TextEditingController(
                text: getValueFromJson('address'),
              ),
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
