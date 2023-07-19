import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/src/typed_buffer.dart';

class MqttPage extends StatefulWidget {
  const MqttPage({super.key});

  @override
  MqttPageState createState() => MqttPageState();
}

class MqttPageState extends State<MqttPage> {
  late MqttServerClient client;
  String receivedMessage = '';

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
    setState(() {});
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
    client.publishMessage(
        topic, MqttQos.exactlyOnce, builder.payload as Uint8Buffer);
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Received Message: $receivedMessage'),
            ElevatedButton(
              child: const Text('Send Message'),
              onPressed: () {
                sendMessage('NCUEMQTT', 'Mqtt message sent by app button');
              },
            ),
          ],
        ),
      ),
    );
  }
}
