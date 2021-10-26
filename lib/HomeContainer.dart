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
    // redditor!.
    return Column(
      children: [
        Text("Communities"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 160.0,
                color: Colors.red,
              ),
              Container(
                width: 160.0,
                color: Colors.blue,
              ),
              Container(
                width: 160.0,
                color: Colors.green,
              ),
              Container(
                width: 160.0,
                color: Colors.yellow,
              ),
              Container(
                width: 160.0,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Future<List<Widget>> fillCommunities() async {
//   List<Widget> commu = [];
//   Stream<SubredditRef> data = redditech!.subreddits.popular(limit: 20);
//   data.forEach((element) { })
// }
