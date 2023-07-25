/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _setupJavascriptBridge();
  }

  void _setupJavascriptBridge() async {
    debugPrint('catch_test');
    if (_isLoggedIn && _webViewController != null) {
      debugPrint('catch_test2');
      _webViewController!.addJavaScriptHandler(
        handlerName: 'userInfo',
        callback: (args) {
          debugPrint('catch_test3');
          // Handle JavaScript bridge callback
          String userInfoJson = args[0];
          Map<String, dynamic> userInfo = jsonDecode(userInfoJson);
          // Use user information for further processing
          debugPrint('User Email: ${userInfo['email']}');
          debugPrint('User pv: ${userInfo['password']}');
        },
      );
    }
  }

  void _handleLogin() {
    // Handle user login logic
    // After successful login, set _isLoggedIn to true
    setState(() {
      _isLoggedIn = true;
    });
    _setupJavascriptBridge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('http://frp.4hotel.tw:25580/')),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        // Other WebView settings
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleLogin,
        child: const Icon(Icons.login),
      ),
    );
  }
}*/

/*import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("JavaScript Handlers")),
          body: SafeArea(
              child: Column(children: <Widget>[
                Expanded(
                  child: InAppWebView(
                    initialData: InAppWebViewInitialData(
                        data: """
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body>
        <h1>JavaScript Handlers</h1>
        <script>
            window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
                window.flutter_inappwebview.callHandler('handlerFoo')
                  .then(function(result) {
                    // print to the console the data coming
                    // from the Flutter side.
                    console.log(JSON.stringify(result));
                    
                    window.flutter_inappwebview
                      .callHandler('handlerFooWithArgs', 1, true, ['bar', 5], {foo: 'baz'},);
                });
            });
        </script>
    </body>
</html>
                      """
                    ),
                    initialOptions: options,
                    onWebViewCreated: (controller) {


                      controller.addJavaScriptHandler(handlerName: 'handlerFooWithArgs', callback: (args) {
                        print(args);
                        // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                      // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
                    },
                  ),
                ),
              ]))),
    );
  }
}*/

