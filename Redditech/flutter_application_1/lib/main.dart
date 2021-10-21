import 'dart:ffi';

import 'package:flutter/material.dart';

import 'LoginController.dart';
import 'HomeController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget firstPage = LoginController(title: 'redd');
    return MaterialApp(
      title: 'Redditech',
      theme: ThemeData(
          fontFamily: 'verdana',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: myColor,
          ),
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.black,
                  fontFamily: 'verdana-bold',
                  fontSize: 20)),
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.black),
          )),
      home: firstPage,
    );
  }
}

const MaterialColor myColor = const MaterialColor(
  0xFFFF5700,
  const <int, Color>{
    50: const Color(0xFFFF5700),
    100: const Color(0xFFFF5700),
    200: const Color(0xFFFF5700),
    300: const Color(0xFFFF5700),
    400: const Color(0xFFFF5700),
    500: const Color(0xFFFF5700),
    600: const Color(0xFFFF5700),
    700: const Color(0xFFFF5700),
    800: const Color(0xFFFF5700),
    900: const Color(0xFFFF5700),
  },
);

// FutureBuilder<bool>(
//           future: _isConnected,
//           initialData: null,
//           builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('auth'),
//                   ),
//                   FloatingActionButton(
//                     onPressed: _accountConnexion,
//                     tooltip: 'Increment',
//                     child: Icon(Icons.add),
//                   ),
//                 ],
//               );
//             } else if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasError) {
//                 return const Text('Error');
//               } else if (snapshot.hasData) {
//                 return Text("nuulllll",
//                     style: const TextStyle(color: Colors.teal, fontSize: 36));
//               } else {
//                 return const Text('Empty data');
//               }
//             } else {
//               return Text('State: ${snapshot.connectionState}');
//             }
//           },

// appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/reddit.png',
//               fit: BoxFit.contain,
//               height: 60,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(widget.title),
//             ),
//           ],
//         ),
//       ),