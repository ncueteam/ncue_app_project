import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQTT Flutter Example',
      home: MQTTExample(),
    );
  }
}

class MQTTExample extends StatefulWidget {
  @override
  _MQTTExampleState createState() => _MQTTExampleState();
}

class _MQTTExampleState extends State<MQTTExample> {
  late MqttServerClient _mqttClient;
  bool _isConnected = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _mqttClient = MqttServerClient('mqtt.example.com', 'flutter_client');
    _mqttClient.port = 1883;

    _mqttClient.logging(on: true);

    _mqttClient.onConnected = _onConnected;
    _mqttClient.onDisconnected = _onDisconnected;
    _mqttClient.onSubscribed = _onSubscribed;
    _mqttClient.onSubscribeFail = _onSubscribeFail;
    _mqttClient.onUnsubscribed = _onUnsubscribed;
    _mqttClient.pongCallback = _pong;

    final mqttConnectMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .keepAliveFor(60)
        .startClean();

    _mqttClient.connectionMessage = mqttConnectMessage;
  }

  void _connect() async {
    try {
      await _mqttClient.connect();
    } catch (e) {
      print('Error connecting to the MQTT server: $e');
    }
  }

  void _disconnect() {
    _mqttClient.disconnect();
  }

  void _subscribe() {
    _mqttClient.subscribe('topic/example', MqttQos.exactlyOnce);
  }

  void _unsubscribe() {
    _mqttClient.unsubscribe('topic/example');
  }

  void _onConnected() {
    setState(() {
      _isConnected = true;
    });
    print('Connected to the MQTT server');
  }

  void _onDisconnected() {
    setState(() {
      _isConnected = false;
    });
    print('Disconnected from the MQTT server');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void _onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void _onUnsubscribed(String topic) {
    print('Unsubscribed from topic: $topic');
  }

  void _pong() {
    print('Ping response received');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('MQTT Flutter Example'),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(_isConnected ? 'Connected' : 'Disconnected'),
    SizedBox(height: 20),
    Text(_message),
    SizedBox(height: 20),
    ElevatedButton(
    onPressed: _isConnected ? _unsubscribe : null,
    child: Text('Unsubscribe'),
    ),
    SizedBox(height: 20),
    ElevatedButton(
    onPressed: _isConnected ? _disconnect : null,
    child: Text('Disconnect'),
    ),
    ],
    ),
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: _isConnected ? _subscribe : _connect,
    child: _isConnected ? Icon(Icons.stop) : Icon(Icons.play_arrow),
    ),
    );
  }
}