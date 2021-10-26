import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:flutter_application_1/HomeController.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'CreditentialLoader.dart';

class LoginController extends StatefulWidget {
  LoginController({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  void _accountConnexion() async {
    final userAgent = 'foobavegeaebaevrvvrvevvzvzr';
    final creditential = await loadCreditentials();
    var reddit;
    print(creditential);

    reddit = Reddit.createInstalledFlowInstance(
        userAgent: userAgent,
        redirectUri: Uri.parse("antonin://fille"),
        clientId: "N2MjyDzaWV2eKc9m9pGHbw");

    final authUrl = reddit.auth.url(['*'], userAgent, compactLogin: true);

    try {
      final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: "antonin",
      );

      final code = Uri.parse(result).queryParameters['code'];

      await reddit.auth.authorize(code!);
      redditech = reddit;
      redditor = await redditech!.user.me();
      saveCreditentials(reddit);
      Navigator.popAndPushNamed(context, '/home');
    } catch (e) {
      print("ERREUR" + e.toString());
      return;
    }
  }

//   void _authentificate() {
//     _redditApi = _accountConnexion as Reddit;
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginBackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/reddit.png',
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: ElevatedButton(
                  onPressed: _accountConnexion,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sing in"),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.login),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
