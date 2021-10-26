import 'package:flutter/material.dart';

class AccountContainer extends StatelessWidget {
  const AccountContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/login');
        },
        child: Text("Logout"),
      ),
    );
  }
}
