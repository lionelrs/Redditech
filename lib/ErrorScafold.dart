import 'package:flutter/material.dart';

class ErrorScafold extends StatefulWidget {
  ErrorScafold({Key? key}) : super(key: key);

  @override
  _ErrorScafoldState createState() => _ErrorScafoldState();
}

class _ErrorScafoldState extends State<ErrorScafold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("ERREUR"),
    );
  }
}
