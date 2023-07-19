// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../services/local_auth_service.dart';

// class WebViewTest extends StatefulWidget {
//   const WebViewTest({Key? key}) : super(key: key);

//   @override
//   WebViewTestState createState() => WebViewTestState();
// }

// class WebViewTestState extends State<WebViewTest> {
//   late final WebViewController controller;
//   // ignore: unused_field
//   InAppWebViewController? _inController;
//   bool authenticated = false;
//   var currentUrl = "http://frp.4hotel.tw:25580/";

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             _getCurrentUrl();
//             debugPrint('URL: $url');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(currentUrl));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WebView Test'),
//         toolbarHeight: 0.0,
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           var canBack = await controller.canGoBack();
//           if (canBack) {
//             // 当网页还有历史记录时，返回webview上一页
//             await controller.goBack();
//             _getCurrentUrl();
//           } else {
//             // 返回原生页面上一页
//             Navigator.of(context).pop();
//           }
//           return false;
//         },
//         child: WebViewWidget(controller: controller),
//       ),
//       floatingActionButton: _fingerPrinter(),
//     );
//   }

//   void _getCurrentUrl() {
//     debugPrint('Current URL3: $currentUrl');
//     // ignore: unnecessary_null_comparison
//     if (controller != null) {
//       controller
//           .runJavaScriptReturningResult("window.location.href")
//           .then((value) {
//         // ignore: unnecessary_null_comparison
//         if (value != null && value != currentUrl) {
//           setState(() {
//             currentUrl = value.toString();
//           });
//           debugPrint('Current URL2: $currentUrl');
//         }
//       });
//     }
//   }

//   Widget _fingerPrinter() {
//     if (currentUrl.toString() == '"http://frp.4hotel.tw:25580/sign-in"') {
//       // Show the floating action button only on the login page
//       return FloatingActionButton(
//         onPressed: () async {
//           final authenticate = await LocalAuth.authenticate();
//           setState(() {
//             authenticated = authenticate;
//           });
//           if (authenticated) {
//             const snackBar = SnackBar(
//               content: Text('You are authenticated.'),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           }
//         },
//         child: const Icon(Icons.fingerprint),
//       );
//     }
//     return Container();
//   }
// }

// /*import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../services/local_auth_service.dart';

// class WebViewTest extends StatefulWidget {
//   const WebViewTest({Key? key}) : super(key: key);

//   @override
//   WebViewTestState createState() => WebViewTestState();
// }

// class WebViewTestState extends State<WebViewTest> {
//   WebViewController? _controller;
//   bool authenticated = false;
//   var currentUrl = "http://frp.4hotel.tw:25580/";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         preferredSize: Size.fromHeight(0),
//         title: const Text('WebView Test'),
//       ),
//     body:
//     WillPopScope(
//     onWillPop: () async {
//       var canBack = await _controller?.canGoBack();
//       if (canBack!) {
//         // 当网页还有历史记录时，返回webview上一页
//         await _controller?.goBack();
//         _getCurrentUrl();
//       } else {
//         // 返回原生页面上一页
//         Navigator.of(context).pop();
//       }
//       return false;
//       },
//       child: WebView(
//         initialUrl: currentUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//         onPageFinished: (url) {
//           debugPrint('URL: $url');
//           _getCurrentUrl();
//         },
//       ),
//     ),
//       floatingActionButton: _fingerPrinter(),
//     );
//   }

//   void _getCurrentUrl() async {
//     if (_controller != null) {
//       String? url =  await _controller!.evaluateJavascript("window.location.href");
//       if (url != null && url != currentUrl) {
//         setState(() {
//           currentUrl = url;
//         });
//         debugPrint('Current URL: $currentUrl');
//         // You can handle your logic here related to the intercepted URL
//       }
//     }
//   }

//   Widget _fingerPrinter() {
//     debugPrint('Current URL2: $currentUrl');
//     if (currentUrl=='"http://frp.4hotel.tw:25580/sign-in"') {//.trim()
//       debugPrint('Current URL3: $currentUrl');
//       // Show the floating action button only on the login page
//       return FloatingActionButton(
//         onPressed: () async {
//           final authenticate = await LocalAuth.authenticate();
//           setState(() {
//             authenticated = authenticate;
//           });
//           const snackBar = SnackBar(
//             content: Text('You are authenticated.'),
//           );
//           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         },
//         child: const Icon(Icons.fingerprint),
//       );
//     }else {
//       return Container();
//     }
//   }
// }*/




