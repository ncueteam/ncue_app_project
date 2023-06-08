import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_01/Mqtt/MQTTAppState.dart';
import 'package:flutter_01/Mqtt/MQTTManager.dart';

class MQTTView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MQTTViewState();
  }
}

class _MQTTViewState extends State<MQTTView> {
  //final TextEditingController _hostTextController = TextEditingController();
  //final TextEditingController _topicTextController = TextEditingController();
  final TextEditingController _messageTextController = TextEditingController();
  late MQTTAppState currentAppState;
  late MQTTManager manager;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //_hostTextController.dispose();
    //_topicTextController.dispose();
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    final Scaffold scaffold = Scaffold(body: _buildColumn());
    return scaffold;
  }

  //MQTT Page排版
  Widget _buildAppBar() {
    return AppBar(
      title: const Text('MQTT Page'),
      //backgroundColor: Colors.greenAccent,
    );
  }

  //排版總集合(呼叫排版用)
  Widget _buildColumn() {
    return Column(
      children: <Widget>[
        _buildAppBar(),
        _buildConnectionStateText(_prepareStateMessageFrom(currentAppState.getAppConnectionState)),
        _buildEditableColumn(),
        _buildScrollableTextWith(currentAppState.getHistoryText)
      ],
    );
  }

  //Enter地址、主題、訊息那欄
  Widget _buildEditableColumn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          /*
          _buildTextFieldWith(_hostTextController, 'Enter broker address',
              currentAppState.getAppConnectionState),
          const SizedBox(height: 10),
          _buildTextFieldWith(
              _topicTextController,
              'Enter a topic to subscribe or listen',
              currentAppState.getAppConnectionState),
          */
          const SizedBox(height: 10),
          _buildPublishMessageRow(),
          const SizedBox(height: 10),
          _buildConnecteButtonFrom(currentAppState.getAppConnectionState)
        ],
      ),
    );
  }

  //Enter a message那欄
  Widget _buildPublishMessageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: _buildTextFieldWith(
              _messageTextController,
              'Enter a message',
              currentAppState.getAppConnectionState),
        ),
        _buildSendButtonFrom(currentAppState.getAppConnectionState)
      ],
    );
  }

  //顯示是否connect(MQTT Page下方那欄)
  Widget _buildConnectionStateText(String status) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              color: Colors.lightBlueAccent,
              child: Text(status, textAlign: TextAlign.center)),
        ),
      ],
    );
  }

  //是否可輸入文字
  Widget _buildTextFieldWith(TextEditingController controller, String hintText, MQTTAppConnectionState state) {
    //bool shouldEnable = false;
    bool shouldEnable = true;
    if (controller == _messageTextController && state == MQTTAppConnectionState.connected) {
      shouldEnable = true;
    }
    /*
    else if ((controller == _hostTextController &&
        state == MQTTAppConnectionState.disconnected) ||
        (controller == _topicTextController &&
            state == MQTTAppConnectionState.disconnected)) {
      shouldEnable = true;
    }*/
    return TextField(
        enabled: shouldEnable,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: hintText,
        ));
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

  //Connect && DisConnect的按鈕
  Widget _buildConnecteButtonFrom(MQTTAppConnectionState state) {
    return Row(
      children: <Widget>[
        Expanded(
          // ignore: deprecated_member_use
          child: ElevatedButton(
            //color: Colors.lightBlueAccent,
            child: const Text('Connect'),
            onPressed: state == MQTTAppConnectionState.disconnected
                ? _configureAndConnect
                : null, //
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // ignore: deprecated_member_use
          child: ElevatedButton(
            //color: Colors.redAccent,
            child: const Text('Disconnect'),
            onPressed: state == MQTTAppConnectionState.connected
                ? _disconnect
                : null, //
          ),
        ),
      ],
    );
  }

  //Send的按鈕
  Widget _buildSendButtonFrom(MQTTAppConnectionState state) {
    // ignore: deprecated_member_use
    return ElevatedButton(
      //color: Colors.blueGrey,
      child: const Text('Send'),
      onPressed: state == MQTTAppConnectionState.connected
      //onPressed: true
        ? () {_publishMessage(_messageTextController.text);}
        : null, //
    );
  }

  // MQTTAppConnectionState的狀態
  String _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {

      case MQTTAppConnectionState.connected:
        return 'Connected';
      case MQTTAppConnectionState.connecting:
        return 'Connecting';
      case MQTTAppConnectionState.disconnected:
        return 'Disconnected';

      /*
      case MQTTAppConnectionState.connected:
        return 'Connected';
      case MQTTAppConnectionState.connecting:
        return 'Connected';
      case MQTTAppConnectionState.disconnected:
        return 'Connected';
      */
    }
  }

  //訂閱主題回傳 && connect通訊
  void _configureAndConnect() {
    // ignore: flutter_style_todos
    // TODO: Use UUID
    String osPrefix = 'NcueApp_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'NcueApp_Android';
    }
    manager = MQTTManager(
        host: 'test.mosquitto.org',
        topic: 'NCUEMQTT',
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  void _publishMessage(String text) {
    String osPrefix = 'NcueApp_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'NcueApp_Android';
    }
    final String message = osPrefix + ' says: ' + text;
    manager.publish(message);
    _messageTextController.clear();
  }
}
