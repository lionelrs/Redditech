import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:draw/draw.dart';

class PostArguments {
  final Subreddit sub;

  PostArguments(this.sub);
}

class PostDisplayController extends StatelessWidget {
  const PostDisplayController({Key? key}) : super(key: key);

  static const routeName = '/PostDisplayController';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
