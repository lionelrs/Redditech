import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:draw/draw.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList(
      {Key? key,
      required this.listInfos,
      required this.tileConstruct,
      required this.title})
      : super(key: key);

  final String title;

  final Future<List<dynamic>> Function(int limit, String? afterFullname)
      listInfos;
  final Widget Function(dynamic) tileConstruct;

  @override
  _InfiniteListState createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  final ScrollController _scrollController = ScrollController();

  List<dynamic> comments = [];
  String typeCom = "top";
  int upDownState = 0;
  bool loading = false, allLoaded = false;
  String? last;

  @override
  void didUpdateWidget(dynamic oldWidget) {
    super.didUpdateWidget(oldWidget);
    comments = [];
    last = null;
    allLoaded = false;
    fetchCom();
  }

  fetchCom() async {
    List<dynamic> result;

    if (allLoaded) {
      return;
    }

    if (!mounted) return;
    setState(() {
      loading = true;
    });
    if (upDownState == 2) {
      result = await widget.listInfos(20, last);
      if (result.isNotEmpty) {
        comments.addAll(result);
      }
    } else {
      result = await widget.listInfos(20, last);
      if (result.isNotEmpty) {
        comments.insertAll(0, result);
      }
    }

    if (!mounted) return;
    setState(() {
      if (result.isNotEmpty && upDownState == 2) {
        last = result[result.length - 1].fullname;
      }
      loading = false;
      allLoaded = result.isEmpty;
      if (result.isEmpty) {
        print("bit");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    upDownState = 2;
    fetchCom();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        upDownState = 2;
        fetchCom();
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
                  itemCount: widget.title == ""
                      ? comments.length + 1
                      : comments.length,
                  separatorBuilder: (BuildContext context, int index) {
                    if (index == 0 && widget.title != "") {
                      // return the header
                      return HeaderList(title: widget.title);
                    } else if (widget.title == "") {
                      index += 1;
                    }
                    index -= 1;

                    return widget.tileConstruct(comments[index]);
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
          } else if (allLoaded) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Sorry, no community was found for \"" + widget.title + "\"",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class HeaderList extends StatelessWidget {
  const HeaderList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Text(
          "search for \"" + title + "\"",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, shadows: [
            Shadow(
                blurRadius: 1,
                color: Theme.of(context).colorScheme.primaryVariant)
          ]),
        ),
      ),
    );
  }
}
