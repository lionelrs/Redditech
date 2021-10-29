import 'package:flutter/material.dart';
import 'package:flutter_application_1/InifiniteList.dart';
import 'package:flutter_application_1/PostDisplayController.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:draw/draw.dart';

class HeaderList {
  String search;

  HeaderList(this.search);
}

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key, required this.callBackCommunities})
      : super(key: key);

  final void Function() callBackCommunities;

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  String _search = "";

  void didUpdateWidget(dynamic oldWidget) {
    super.didUpdateWidget(oldWidget);
    _search = globalSearch;
  }

  void refreshCommunities() {
    widget.callBackCommunities();
  }

  Widget constructWidget(dynamic subreddit) {
    return TileSubreddit(
      subredd: subreddit,
      returnFromPage: refreshCommunities,
    );
  }

  void callBack(String search) {
    if (!mounted) return;
    setState(() {
      _search = search;
      print("ttest");
    });
  }

  Future<List<dynamic>> listSub(int limite, String? atferFullName) async {
    List<Subreddit> displayList = [];
    List<SubredditRef> tmp = [];
    if (_search == "") {
      tmp = await redditech!.subreddits.popular(
          limit: limite, params: {"after": atferFullName ?? ""}).toList();
    } else {
      tmp = await redditech!.subreddits.search(_search,
          limit: limite, params: {"after": atferFullName ?? ""}).toList();
    }

    tmp.forEach((element) {
      displayList.add(element as Subreddit);
    });

    return displayList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfiniteList(
          listInfos: listSub,
          tileConstruct: constructWidget,
          title: _search,
        ),
      ],
    );
  }
}

class TileSubreddit extends StatelessWidget {
  const TileSubreddit(
      {Key? key, required this.subredd, required this.returnFromPage})
      : super(key: key);

  final Subreddit subredd;
  final void Function() returnFromPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/postSubreddit',
          arguments: PostArguments(subredd),
        ).then((value) => returnFromPage());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: Theme.of(context).colorScheme.secondary)
                  ],
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundImage: NetworkImage(subredd.iconImage.toString()),
                  onForegroundImageError: (test, err) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  child: Text(subredd.displayName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
