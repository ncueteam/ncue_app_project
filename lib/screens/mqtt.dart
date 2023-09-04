import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// ignore: implementation_imports, depend_on_referenced_packages
import 'package:typed_data/src/typed_buffer.dart';

class MqttPage extends StatefulWidget {
  const MqttPage({super.key});

  @override
  MqttPageState createState() => MqttPageState();
}

class MqttPageState extends State<MqttPage> {
  late MqttServerClient client;
  final messageToSend = TextEditingController();
  List<Widget> widgetList = [];

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
    connect();
    widgetList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
            controller: messageToSend,
            decoration: const InputDecoration(
              labelText: '發出訊息',
              hintText: '要發出的訊息',
              prefixIcon: Icon(Icons.send),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) =>
                {sendMessage('NCUEMQTT', value), messageToSend.clear()})));
    widgetList.add(messageComponent("等待接收資料..."));
    super.initState();
  }

  @override
  void dispose() {
    messageToSend.dispose();
    // client.disconnect();
    super.dispose();
  }

  void connect() async {
    client = MqttServerClient('test.mosquitto.org', 'ncue_app');
    client.disconnect();
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
        widgetList.add(messageComponent("連線中...."));
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
          widgetList.add(messageComponent("收到 > $messageText"));
        });
      }
    });
  }

  void onSubscribed(String topic) {
    setState(() {
      widgetList.add(messageComponent("開始訂閱資料: $topic"));
    });
  }

  void onDisconnected() {
    // setState(() {
    //   widgetList.add(messageComponent("失去連線"));
    // });
  }

  void onUnsubscribed(String? topic) {
    setState(() {
      widgetList.add(messageComponent("停止訂閱主題: $topic"));
    });
  }

  void pong() {
    setState(() {
      widgetList.add(messageComponent("pong"));
    });
  }

  void sendMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(
        topic, MqttQos.exactlyOnce, builder.payload as Uint8Buffer);
    setState(() {
      widgetList.add(messageComponent("送出 < $message"));
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
            children: widgetList),
      ),
    );
  }
}
