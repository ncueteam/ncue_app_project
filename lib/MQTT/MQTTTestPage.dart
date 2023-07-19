import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/cupertino.dart';

class MQTTTestPage extends StatefulWidget {
  @override
  _MQTTTestPageState createState() => _MQTTTestPageState();
}

class _MQTTTestPageState extends State<MQTTTestPage> with ChangeNotifier {
  late MqttServerClient client;
  String receivedMessage = '';
  String historyMessage = '';

  void setReceivedText(String text) {
    receivedMessage = text;
    historyMessage = historyMessage + '\n' + receivedMessage;
    notifyListeners();
  }

  String get getReceivedText => receivedMessage;
  String get getHistoryText => historyMessage;

  @override
  Widget build(BuildContext context) {
    final Scaffold scaffold = Scaffold(body: _buildColumn());
    return scaffold;
  }

  //MQTT Page排版
  Widget _buildAppBar() {
    return AppBar(
      title: const Text('MQTT Page'),
    );
  }

  //Send的按鈕
  Widget _buildSendButtonFrom() {
    // ignore: deprecated_member_use
    return ElevatedButton(
      //color: Colors.blueGrey,
      child: const Text('Send'),
      onPressed: () {
        sendMessage('NCUEMQTT', 'Mqtt message sent by app button');
        setReceivedText('Mqtt message sent by app button');
      },
    );
  }

  //訂閱、發布的文字欄
  Widget _buildScrollableTextWith(String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 400,
        height: 200,
        child: SingleChildScrollView(
          child: Text(text),
        ),
      ),
    );
  }

  //排版總集合(呼叫排版用)
  Widget _buildColumn() {
    return Column(
      children: <Widget>[
        _buildAppBar(),
        _buildSendButtonFrom(),
        _buildScrollableTextWith(getHistoryText)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    client = MqttServerClient('test.mosquitto.org', 'ncue_app');
    client.port = 1883;
    client.logging(on: true);

    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        // .authenticateAs('username', 'password')
        .withWillTopic('NCUEMQTT')
        .withWillMessage('MQTT Connect from App')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      debugPrint('Exception: $e');
      client.disconnect();
    }
  }

  void onConnected() {
    debugPrint('Connected');
    client.subscribe('receive_topic', MqttQos.exactlyOnce);
    client.subscribe('NCUEMQTT', MqttQos.exactlyOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      for (var message in messages) {
        final MqttPublishMessage payload =
            message.payload as MqttPublishMessage;
        final String messageText =
            MqttPublishPayload.bytesToStringAsString(payload.payload.message);
        setState(() {
          receivedMessage = messageText;
        });
        debugPrint('Received message: $messageText');
      }
    });
  }

  void onSubscribed(String topic) {
    debugPrint('Subscribed to topic: $topic');
  }

  void onDisconnected() {
    debugPrint('Disconnected');
  }

  void onUnsubscribed(String? topic) {
    debugPrint('Unsubscribed from topic: $topic');
  }

  void pong() {
    debugPrint('Ping response');
  }

  void sendMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }
}
