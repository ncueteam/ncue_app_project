import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/local_auth_service.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  WebViewTestState createState() => WebViewTestState();
}

class WebViewTestState extends State<WebViewTest> {
  //WebViewController _controller = <WebViewController>;
  WebViewController? _controller;
  bool authenticated = false;
  var currentUrl = "http://frp.4hotel.tw:25580/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Test'),
      ),
      body:
      WillPopScope(
        onWillPop: () async {
          var canBack = await _controller?.canGoBack();
          if (canBack!) {
            // 当网页还有历史记录时，返回webview上一页
            await _controller?.goBack();
          } else {
            // 返回原生页面上一页
            Navigator.of(context).pop();
          }
          return false;
          },
        child : WebView(
          initialUrl: currentUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller=webViewController;
          },
          onPageStarted: (url) {
            debugPrint('Page started: $url');
          },
          onPageFinished: (url) {
            setState(() {
              currentUrl = url;
            });
            debugPrint('Page finished: $url');
          },
        ),
      ),
      floatingActionButton: _fingerPrinter(),
    );
  }

  _fingerPrinter() {
          if (currentUrl.toString() == "http://frp.4hotel.tw:25580/tables") {
            return FloatingActionButton(
              onPressed: () async {
                final authenticate = await LocalAuth.authenticate();
                setState(() {
                  authenticated = authenticate;
                });
                const snackBar = SnackBar(
                  content: Text('You are authenticated.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Icon(Icons.fingerprint),
            );
          }
        }
}

