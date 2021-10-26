import 'package:flutter/material.dart';

AppBar applicationBar() {
  return AppBar(
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
  );
}
