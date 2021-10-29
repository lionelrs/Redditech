import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 6,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(
        indicatorColor: Colors.white,
        unselectedLabelColor: Theme.of(context).colorScheme.secondary,
        labelColor: Theme.of(context).colorScheme.primaryVariant,
        tabs: [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.settings_rounded),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
