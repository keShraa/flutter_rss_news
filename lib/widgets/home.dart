import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_rss_news/models/parser.dart';
import 'package:webfeed/webfeed.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  RssFeed feed;
  List<Card> cardNews;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    parse();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ((orientation == Orientation.portrait)? list() : grid()),
      ),
    );
  }

  // Parse RssFeed
  Future<Null> parse() async {
    RssFeed received = await Parser().loadRSS();
    if (received != null) {
      setState(() {
        feed = received;
        int i = 0;

        feed.items.forEach((feedItem) {
          RssItem item = feedItem;
          cardNews[i] = cardItem(item);
          i++;
        });

      });
    }
  }

  // Build card
  Card cardItem(RssItem item) {
    return Card(
      elevation: 4.0,
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
                  styledText(item.title, Colors.deepOrange, 1.6, TextAlign.center),
                  styledText(item.pubDate, Colors.grey[500], 0.8, TextAlign.center),
                  Padding(padding: EdgeInsets.all(10.0)),
                  styledText(item.description, Colors.black, 1.1, TextAlign.justify),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build styled text
  Text styledText(String data, Color color, double factor, align) {
    return Text(
      data,
      textAlign: align,
      textScaleFactor: factor,
      style: TextStyle(
        color: color,
      ),
    );
  }

  // Build List
  Widget list() {
    return ListView.builder(
        itemCount: feed.items.length,
        itemBuilder: (context, i) {
          RssItem item = feed.items[i];
          String key = item.title;
          return Dismissible(
            key: Key(key),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: cardItem(item),
            ),
          );
        });
  }

  // Build Grid
  Widget grid() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: cardNews.length,
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              elevation: 14.0,
              child: InkWell(
                onTap: (() => print('Tapped grid')),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    styledText(feed.items[i].title, Colors.deepOrange, 2.0, TextAlign.center),
                    styledText(feed.items[i].pubDate, Colors.deepOrange[300], 0.8, TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
