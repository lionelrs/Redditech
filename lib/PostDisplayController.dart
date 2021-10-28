import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:draw/draw.dart';
import 'package:flutter_application_1/InifiniteList.dart';

class PostArguments {
  final Subreddit sub;

  PostArguments(this.sub);
}

class PostDisplayController extends StatefulWidget {
  const PostDisplayController({Key? key}) : super(key: key);

  static const routeName = '/PostDisplayController';

  @override
  _PostDisplayControllerState createState() => _PostDisplayControllerState();
}

class _PostDisplayControllerState extends State<PostDisplayController> {
  String _filter = "hot";

  Widget postCreator(dynamic sub) {
    return PostTile(sub: sub);
  }

  Future<List<dynamic>> listSub(int limite, String? atferFullName) async {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    List<Submission> resultList = [];
    List<UserContent> tmp = [];

    if (_filter == "hot") {
      print("hot");
      tmp = await args.sub.hot(limit: limite, after: atferFullName).toList();
    } else if (_filter == "top") {
      print("top");
      tmp = await args.sub.top(limit: limite, after: atferFullName).toList();
    } else {
      print("newest");
      tmp = await args.sub.newest(limit: limite, after: atferFullName).toList();
    }

    tmp.forEach((element) {
      resultList.add(element as Submission);
    });

    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;

    void callBack(String filter) {
      setState(() {
        _filter = filter;
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "r/" + args.sub.title,
            style: TextStyle(fontSize: 10),
          ),
          actions: <Widget>[],
        ),
        body: ListView(
          children: <Widget>[
            HeaderSubreddit(
              sub: args.sub,
              callback: callBack,
            ),
            InfiniteList(
              listInfos: listSub,
              tileConstruct: postCreator,
              title: "",
            ),
          ],
        ));
  }
}

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.sub}) : super(key: key);

  final Submission sub;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      sub.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ),
              if (sub.thumbnail.toString().contains("http")) ...[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(sub.thumbnail.toString()),
                  ),
                ),
              ],
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_circle_up),
                ),
                Text(k_m_b_generator(sub.score)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_circle_down),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String k_m_b_generator(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} K";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)} K";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} M";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} B";
  } else {
    return num.toString();
  }
}

class HeaderSubreddit extends StatelessWidget {
  const HeaderSubreddit({Key? key, required this.sub, required this.callback})
      : super(key: key);

  final void Function(String) callback;

  final Subreddit sub;

  Widget _offsetPopup() => PopupMenuButton<String>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "newest",
            child: Text(
              "newest",
            ),
          ),
          PopupMenuItem(
            value: "top",
            child: Text(
              "top",
            ),
          ),
          PopupMenuItem(
            value: "hot",
            child: Text(
              "hot",
            ),
          ),
        ],
        onSelected: (value) {
          callback(value);
        },
        icon: Icon(Icons.filter_list_alt),
        offset: Offset(0, 50),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Positioned(
                top: 1,
                right: 1,
                child: SizedBox(
                  height: 40,
                  width: 100,
                  child: sub.headerImage.toString().contains("http")
                      ? Image.network(sub.headerImage.toString())
                      : Container(),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subIdentity(sub: sub),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _offsetPopup(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class subIdentity extends StatelessWidget {
  const subIdentity({Key? key, required this.sub}) : super(key: key);

  final Subreddit sub;

  String MembersFormatString(String nbrSub) {
    String res = nbrSub.split('').reversed.join();
    res =
        res.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");
    return res.split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    print("SUBBBBBBBB");
    inspect(sub);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(sub.iconImage.toString()),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      sub.displayName,
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * (2 / 3) - 10,
                    child: Text(
                      sub.title,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            MembersFormatString(sub.data!["subscribers"].toString()) +
                " members ",
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).textTheme.caption!.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * (2 / 3),
              child: Text(
                sub.data!["public_description"].toString(),
                maxLines: 3,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
