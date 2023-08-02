import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'login.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  WebViewTestState createState() => WebViewTestState();
}

class WebViewTestState extends State<WebViewTest> {
  late final WebViewController controller;
  bool authenticated = false;
  var currentUrl = "http://frp.4hotel.tw:25580/";

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _getCurrentUrl();
            debugPrint('URL: $url');
          },
        ),
      )
      ..loadRequest(Uri.parse(currentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Test'),
        toolbarHeight: 0.0,
      ),
    body:
      WillPopScope(
        onWillPop: () async {
          var canBack = await controller.canGoBack();
          if (canBack) {
            // 当网页还有历史记录时，返回webview上一页
            await controller.goBack();
            _getCurrentUrl();
          } else {
            // 返回原生页面上一页
            Navigator.of(context).pop();
          }
          return false;
        },
        child: WebViewWidget(controller: controller),
      ),
    );
  }

  void _getCurrentUrl() {
    debugPrint('Current URL3: $currentUrl');
    if (controller != null) {
      controller.runJavaScriptReturningResult("window.location.href").then((value){
        if (value != null && value != currentUrl) {
          setState(() {
            currentUrl = value.toString();
          });
          debugPrint('Current URL2: $currentUrl');
          if (currentUrl.toString() == '"http://frp.4hotel.tw:25580/sign-in"') {
            debugPrint('Current URL4: $currentUrl');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const LoginRoute()),
            );
          }
        }
      });
    }
  }
}
