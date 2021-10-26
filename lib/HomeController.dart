import 'dart:developer';

import 'package:flutter_application_1/AccountContainer.dart';
import 'package:flutter_application_1/HomeContainer.dart';
import 'package:flutter_application_1/MessageContainer.dart';

import 'BottomNavigation.dart';
import 'commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CreditentialLoader.dart';
import 'package:flutter_application_1/LoginController.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class HomeController extends StatefulWidget {
  HomeController({Key? key}) : super(key: key);

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/reddit.png',
              fit: BoxFit.contain,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Redditech"),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: BottomNavigation(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeContainer(),
              MessageContainer(),
              Container(child: Icon(Icons.directions_bike)),
              AccountContainer(),
            ],
          ),
        ),
      ),
    );
  }
}


// Center(
//         child: ElevatedButton(
//           onPressed: () {
//             inspect(redditech);
//             suprCreditentials();
//             Navigator.popAndPushNamed(context, '/login');
//           },
//           child: const Text("logout"),
//         ),
//       ),