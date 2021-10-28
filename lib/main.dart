import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:flutter_application_1/ErrorScafold.dart';

import 'globals.dart';

import 'LoginController.dart';
import 'HomeController.dart';
import 'CreditentialLoader.dart';
import 'PostDisplayController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      theme: ThemeData(
        fontFamily: 'verdana',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: myColor,
          accentColor: Color(0xFFC6C6C6),
          primaryColorDark: Color(0xFF222222),
        ),
        primaryTextTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black, fontFamily: 'verdana-bold', fontSize: 20)),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black),
          caption: TextStyle(
              color: Color(0xFFA5A4A4), fontFamily: 'verdana', fontSize: 10),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future: isAuth(),
              builder: (BuildContext context, AsyncSnapshot<Widget> widget) {
                if (widget.connectionState == ConnectionState.done) {
                  if (!widget.hasData) {
                    return ErrorScafold();
                  }
                  return widget.data!;
                } else {
                  return ErrorScafold();
                }
              },
            ),
        '/home': (context) => HomeController(),
        '/login': (context) => LoginController(title: 'red'),
        '/postSubreddit': (context) => PostDisplayController(),
      },
    );
  }
}

Future<Widget> isAuth() async {
  final creditential = await loadCreditentials();

  if (creditential != null) {
    return LoginController(title: "login");
  } else {
    redditech = Reddit.restoreAuthenticatedInstance(
      creditential,
      clientId: "N2MjyDzaWV2eKc9m9pGHbw",
      userAgent: 'foobavegeaebaevrvvrvevvzvzr',
    );
    redditor = await redditech!.user.me();
    return HomeController();
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