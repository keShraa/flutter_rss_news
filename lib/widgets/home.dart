import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter_rss_news/models/parser.dart';
import 'package:flutter_rss_news/widgets/loading.dart';
import 'package:webfeed/webfeed.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rss_news/widgets/convertDate.dart';
import 'package:flutter_rss_news/widgets/styledText.dart';
import 'package:flutter_rss_news/widgets/show_new.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  RssFeed feed;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    parse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                feed = null;
                parse();
              });
            },
          ),
        ],
      ),
      body: choixDuBody(),
    );
  }

  Widget choixDuBody() {
    if (feed == null) {
      return Center(
        child: Loading(),
      );
    } else {
      Orientation orientation = MediaQuery.of(context).orientation;
      return Center(
        child: ((orientation == Orientation.portrait)? list() : grid()),
      );
    }
  }

  // Parse RssFeed
  Future<Null> parse() async {
    RssFeed received = await Parser().loadRSS();
    if (received != null) {
      setState(() {
        feed = received;
      });
    }
  }

  // Build card
  Card cardItem(RssItem item) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: (() {
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
            return ShowNew(item);
          }));
        }),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                height: 160.0,
                width: MediaQuery.of(context).size.width - 20.0,
                fit: BoxFit.cover,
                image: NetworkImage(item.enclosure.url),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    StyledText(item.title, color: Colors.deepOrange, factor: 1.6),
                    Padding(padding: EdgeInsets.all(10.0)),
                    StyledText(item.description, color: Colors.black, factor: 1.1),
                    Padding(padding: EdgeInsets.all(10.0)),
                    StyledText(ConvertDate().publishedDateToString(item.pubDate), color: Colors.grey[500],  factor: 0.8, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  // Build List
  Widget list() {
    return ListView.builder(
        itemCount: feed.items.length,
        itemBuilder: (context, i) {
          RssItem item = feed.items[i];
          return Container(
            padding: EdgeInsets.all(8.0),
            child: cardItem(item),
          );
        }
    );
  }

  // Build Grid
  Widget grid() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: feed.items.length,
        itemBuilder: (context, i) {
          RssItem item = feed.items[i];
          return Container(
            child: Card(
              elevation: 4.0,
              child: InkWell(
                onTap: (() {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                        return ShowNew(item);
                      }));
                }),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                            height: 90.0,
                            width: MediaQuery.of(context).size.width - 20.0,
                            fit: BoxFit.cover,
                            image: NetworkImage(item.enclosure.url),
                          ),
                          Padding(padding: EdgeInsets.all(4.0),),
                          StyledText(item.title, color: Colors.deepOrange, factor: 1.0),
                        ],
                      ),
                      StyledText(ConvertDate().publishedDateToString(item.pubDate), color: Colors.grey[500], factor: 0.6, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

}
