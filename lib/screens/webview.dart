import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/local_auth_service.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  WebViewTestState createState() => WebViewTestState();
}

class WebViewTestState extends State<WebViewTest> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Test'),
      ),
      body: WebView(
        initialUrl: 'http://frp.4hotel.tw:25580/profile',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      //floatingActionButton: fingerPrinter(),
        /*FloatingActionButton(
          onPressed: () async {
            final authenticate = await LocalAuth.authenticate();
            setState(() {
              authenticated = authenticate;
            });
          },
          child: const Icon(Icons.fingerprint),
        )*/
    );
  }

  fingerPrinter() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
            if(controller.data!.currentUrl().toString()=='http://frp.4hotel.tw:25580/sign-in'){
              debugPrint(controller.data!.currentUrl().toString());
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
            return Container();
          },
    );
  }
}
/*if (authenticated) {
      const snackBar = SnackBar(
        content: Text('You are authenticated.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (authenticated){
      FloatingActionButton(
          onPressed: () {
            setState(() {
              authenticated = false;
            });
            },
          child: const Icon(Icons.logout),
      );
    }*/