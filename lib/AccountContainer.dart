import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals.dart';

class AccountContainer extends StatelessWidget {
  const AccountContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            UserInfo(),
            KarmaAndCake(),
            Coins(),
            Premium(),
            LogoutButton(),
            Container(
              height: MediaQuery.of(context).size.height / 5,
            )
          ],
        ),
      ),
    );
  }
}

class Premium extends StatelessWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width / 10,
            MediaQuery.of(context).size.height / 12),
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Image.asset(
                'assets/images/Premium.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Reddit Premium",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Ads-free browsing"),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Coins extends StatelessWidget {
  const Coins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width / 10,
            MediaQuery.of(context).size.height / 12),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Coin.png',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height / 30,
            ),
            Container(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Reddit Coins",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(redditor!.data!["coins"].toString() + " Coins"),
                ],
              ),
            )
          ],
        ));
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, MediaQuery.of(context).size.height / 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/login');
        },
        child: Text("Logout"),
      ),
    );
  }
}

class KarmaAndCake extends StatelessWidget {
  const KarmaAndCake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, MediaQuery.of(context).size.height / 12),
      child: IntrinsicHeight(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: KarmaBox(),
              ),
              VerticalDivider(),
              Container(
                child: CakeBox(),
              ),
            ]),
      ),
    );
  }
}

class KarmaBox extends StatelessWidget {
  const KarmaBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/Karma.png',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height / 20,
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  redditor!.data!['total_karma'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "karma",
                ),
              ]),
        ),
      ],
    );
  }
}

class CakeBox extends StatelessWidget {
  const CakeBox({Key? key}) : super(key: key);

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Text days() {
    final birthday = DateTime(redditor!.createdUtc!.year,
        redditor!.createdUtc!.month, redditor!.createdUtc!.day);
    final date2 = DateTime.now();
    final difference = daysBetween(birthday, date2);
    return Text(
      difference.toString() + "d",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/Cake.png',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height / 20,
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                days(),
                Text(
                  "Reddit age",
                ),
              ]),
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Transform.translate(
              offset: Offset(0.0, MediaQuery.of(context).size.height / 15),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffdfdcdb),
                ),
                width: MediaQuery.of(context).size.width - 70,
                height: MediaQuery.of(context).size.width - 120,
              )),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0.0, MediaQuery.of(context).size.height / 100),
            child: Container(
              child: Image.network(
                redditor!.data!["snoovatar_img"],
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 4,
                // fit: BoxFit.co,
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0.0, MediaQuery.of(context).size.height / 3.7),
            child: Container(
              child: Text(
                redditor!.data!['subreddit']['display_name_prefixed'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0.0, MediaQuery.of(context).size.height / 3.2),
            child: Container(
              child: Text(
                redditor!.data!['subreddit']['public_description'],
                // style: TextStyle(
                //   fontWeight: FontWeight.bold
                // ),
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0.0, MediaQuery.of(context).size.height / 2.85),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.green),
                  left: BorderSide(width: 1.0, color: Colors.green),
                  right: BorderSide(width: 1.0, color: Colors.green),
                  bottom: BorderSide(width: 1.0, color: Colors.green),
                ),
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffdfdcdb),
              ),
              child: Text(
                "Online Status: On",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
