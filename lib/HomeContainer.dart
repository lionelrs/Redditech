import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/PostDisplayController.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:draw/draw.dart';

import 'FeedWidget.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  String search = "";

  void callBackCommunities() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return ListView(
      children: <Widget>[
        CommunitiesWidget(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(0.0, 4),
              )
            ],
          ),
          child: Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {}
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                  child: Container(
                    width: 250,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        globalSearch = value;
                        if (!mounted) return null;
                        setState(() {});
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        FeedWidget(
          callBackCommunities: callBackCommunities,
        ),
      ],
    );
  }
}

class CommunitiesWidget extends StatelessWidget {
  const CommunitiesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // redditor!.
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text(
              "Communities",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.0,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ComunitiIconeName(),
          )
        ],
      ),
    );
  }
}

class ComunitiIconeName extends StatefulWidget {
  const ComunitiIconeName({Key? key}) : super(key: key);

  @override
  _ComunitiIconeNameState createState() => _ComunitiIconeNameState();
}

class _ComunitiIconeNameState extends State<ComunitiIconeName> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fillCommunities(),
      builder: (BuildContext context, AsyncSnapshot<List<SubredditRef>> list) {
        if (list.connectionState == ConnectionState.done) {
          if (!list.hasData) {
            return Center(child: Text("null"));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.data!.length,
            itemBuilder: (context, index) {
              Subreddit subred = list.data![index] as Subreddit;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/postSubreddit',
                            arguments: PostArguments(subred))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 7),
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              radius: 30,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                foregroundImage:
                                    NetworkImage(subred.iconImage.toString()),
                                onForegroundImageError: (test, err) {},
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'r/' + subred.displayName,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<List<SubredditRef>> fillCommunities() async {
  List<Widget> commu = [];
  final data = redditech!.user.subreddits(limit: 20);
  final result = await data.toList();

  return result;
}

 // Column(
    //   children: [
    //     Text("Communities"),
    //     Container(
    //       margin: const EdgeInsets.symmetric(vertical: 20.0),
    //       height: 100,
    //       child: ListView.builder(itemBuilder: (context, index),),
          // child: ListView(
          //   scrollDirection: Axis.horizontal,
          //   children: <Widget>[
          //     Container(
          //       width: 160.0,
          //       color: Colors.red,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.blue,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.green,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.yellow,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.orange,
          //     ),
          //   ],
          // ),