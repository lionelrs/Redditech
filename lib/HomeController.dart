import 'package:flutter_application_1/AccountContainer.dart';
import 'package:flutter_application_1/HomeContainer.dart';
import 'package:flutter_application_1/SettingsContainer.dart';

import 'BottomNavigation.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.white,
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
              child: Text(
                "Redditech",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: BottomNavigation(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeContainer(),
              SettingsContainer(),
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