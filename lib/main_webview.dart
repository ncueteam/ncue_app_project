//import 'dart:js_util';
//import 'dart:async';
//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  final _resultInfo = 'Hello,Vue!';
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('http://frp.4hotel.tw:25580/'),
        //'assets/Profile.vue'
        //'assets/vue-soft-ui-dashboard-main/src/views/Profile.vue'
        //'http://localhost:8080/'
      )
      ..addJavaScriptChannel('getInfoFromVue',
          onMessageReceived: (JavaScriptMessage message) {
            debugPrint('收到消息${message.message}');
            flutterWebViewPlugin
                .evalJavascript("window.getInfoFromFlutter('$_resultInfo')")
                .then((result) {})
                .catchError((onError) {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}


/*void _updateSettings() async {
    if (controller != null) {
      await controller!.evalJavascript(
        // Modify the WebView settings
        if (window.androidBridge) {
          // Check if the Android WebView bridge object exists (for Android)
          window.androidBridge.setAllowFileAccess($allow);
        } else {
          // Otherwise, use default settings
          console.warn('WebView bridge object not found.');
        }
      );
    }
  }*/
/*if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }*/
/*import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  // Specify the directory where your files are located
  final staticHandler = createStaticHandler('path_to_your_files', defaultDocument: 'index.html');

  final port = 8080; // Choose a port for the local server
  final server = shelf_io.serve(staticHandler, 'localhost', port);

  print('Local server running at http://localhost:$port');

  // Run the app
  runApp(MyApp());

  // Cancel the server when the app is closed
  server.then((_) {
    print('Local server stopped');
  });
}
class MyWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://localhost:8080', // Use the URL of your local server
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('WebView Example'),
      ),
      body: MyWebView(),
    ),
  ));
}*/
