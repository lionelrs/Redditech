import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:draw/draw.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommunitiesWidget(),
      ],
    );
  }
}

class CommunitiesWidget extends StatelessWidget {
  const CommunitiesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    inspect(redditor);
    // redditor!.
    return SizedBox(
      height: 60,
      child: //Center(child: Text("test")),
          FutureBuilder(
        future: fillCommunities(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SubredditRef>> list) {
          if (list.connectionState == ConnectionState.done) {
            if (!list.hasData) {
              return Center(child: Text("null"));
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  child: Column(
                    children: [
                      Text('r/' + list.data![index].displayName),
                    ],
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
      ),
    );
  }
}

Future<List<SubredditRef>> fillCommunities() async {
  List<Widget> commu = [];
  final data = redditech!.subreddits.popular(limit: 20);
  final result = await data.toList();

  inspect(result);

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