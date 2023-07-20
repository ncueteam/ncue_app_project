import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:typed_data/src/typed_buffer.dart';

class MqttPage extends StatefulWidget {
  const MqttPage({super.key});

  @override
  MqttPageState createState() => MqttPageState();
}

class MqttPageState extends State<MqttPage> {
  late MqttServerClient client;
  // ignore: non_constant_identifier_names
  final message_to_send = TextEditingController();
  List<Widget> components = [];

  Widget messageComponent(String msg) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(msg),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    connect();
    components.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
            controller: message_to_send,
            decoration: const InputDecoration(
              labelText: '發出訊息',
              hintText: '要發出的訊息',
              prefixIcon: Icon(Icons.send),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) =>
                {sendMessage('NCUEMQTT', value), message_to_send.clear()})));
    components.add(messageComponent("等待接收資料..."));
  }

  @override
  void dispose() {
    message_to_send.dispose();
    client.disconnect();
    super.dispose();
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
      setState(() {
        components.add(messageComponent("連線中...."));
      });
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
          components.add(messageComponent("收到 > $messageText"));
        });
      }
    });
  }

  void onSubscribed(String topic) {
    setState(() {
      components.add(messageComponent("開始訂閱資料: $topic"));
    });
  }

  void onDisconnected() {
    setState(() {
      components.add(messageComponent("失去連線"));
    });
  }

  void onUnsubscribed(String? topic) {
    setState(() {
      components.add(messageComponent("停止訂閱主題: $topic"));
    });
  }

  void pong() {
    setState(() {
      components.add(messageComponent("pong"));
    });
  }

  void sendMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(
        topic, MqttQos.exactlyOnce, builder.payload as Uint8Buffer);
    setState(() {
      components.add(messageComponent("送出 < $message"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Page'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: components),
      ),
    );
  }
}
