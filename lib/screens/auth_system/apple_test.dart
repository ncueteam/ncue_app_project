import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleTest extends StatefulWidget {
  const AppleTest({Key? key}) : super(key: key);

  @override
  _AppleTestState createState() => _AppleTestState();
}

class _AppleTestState extends State<AppleTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: ((settings) {
        // This is also invoked for incoming deep links

        // ignore: avoid_print
        print('onGenerateRoute: $settings');

        return null;
      }),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app: Sign in with Apple'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SignInWithAppleButton(
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                  webAuthenticationOptions: WebAuthenticationOptions(
                    clientId:
                        'de.lunaone.flutter.signinwithappleexample.service',
                    redirectUri: Uri.parse(
                      'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                    ),
                  ),
                  nonce: 'example-nonce',
                  state: 'example-state',
                );

                // ignore: avoid_print
                print(credential);

                // This is the endpoint that will convert an authorization code obtained
                // via Sign in with Apple into a session in your system
                final signInWithAppleEndpoint = Uri(
                  scheme: 'https',
                  host: 'flutter-sign-in-with-apple-example.glitch.me',
                  path: '/sign_in_with_apple',
                  queryParameters: <String, String>{
                    'code': credential.authorizationCode,
                    if (credential.givenName != null)
                      'firstName': credential.givenName!,
                    if (credential.familyName != null)
                      'lastName': credential.familyName!,
                    'useBundleId':
                        !kIsWeb && (Platform.isIOS || Platform.isMacOS)
                            ? 'true'
                            : 'false',
                    if (credential.state != null) 'state': credential.state!,
                  },
                );

                final session = await http.Client().post(
                  signInWithAppleEndpoint,
                );

                // If we got this far, a session based on the Apple ID credential has been created in your system,
                // and you can now set this as the app's session
                // ignore: avoid_print
                print(session);
              },
            ),
          ),
        ),
      ),
    );
  }
}
