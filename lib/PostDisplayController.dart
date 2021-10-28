import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "r/" + args.sub.title,
            style: TextStyle(fontSize: 10),
          ),
          actions: <Widget>[],
        ),
        body: ListView(
          children: <Widget>[
            HeaderSubreddit(sub: args.sub),
            PostView(sub: args.sub),
          ],
        ));
  }
}

class PostView extends StatefulWidget {
  const PostView({Key? key, required this.sub}) : super(key: key);

  final Subreddit sub;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final ScrollController _scrollController = ScrollController();

  List<UserContent> comments = [];
  String typeCom = "top";
  int upDownState = 0;
  bool loading = false, allLoaded = false;
  String? last;

  fetchCom(String type) async {
    List<UserContent> result;

    if (allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });
    if (upDownState == 2) {
      if (type == "top") {
        result = await widget.sub.top(limit: 20, after: last).toList();
      } else {
        result = await widget.sub.top(limit: 20, after: last).toList();
      }
      if (result.isNotEmpty) {
        comments.addAll(result);
      }
    } else {
      if (type == "top") {
        result = await widget.sub.top(limit: 5).toList();
      } else {
        result = await widget.sub.top(limit: 5).toList();
      }
      if (result.isNotEmpty) {
        comments.insertAll(0, result);
      }
    }

    setState(() {
      if (result.isNotEmpty && upDownState == 2) {
        last = (result[19] as Submission).fullname;
      }
      loading = false;
      allLoaded = result.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    upDownState = 2;
    fetchCom(typeCom);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        upDownState = 2;
        fetchCom(typeCom);
        print("non");
      }
      // if (_scrollController.position.pixels <=
      //         _scrollController.position.minScrollExtent &&
      //     !loading) {
      //   upDownState = 1;
      //   fetchCom(typeCom);
      // }
    });
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (comments.isNotEmpty) {
            return Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  itemCount: comments.length,
                  separatorBuilder: (BuildContext context, int index) {
                    Submission comment = comments[index] as Submission;
                    return PostTile(sub: comment);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),
                if (loading) ...[
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: constraints.maxWidth,
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ]
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.sub}) : super(key: key);

  final Submission sub;

  @override
  Widget build(BuildContext context) {
    inspect(sub);
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
  const HeaderSubreddit({Key? key, required this.sub}) : super(key: key);

  final Subreddit sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(sub.title),
        ),
      ),
    );
  }
}
