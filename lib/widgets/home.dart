import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_rss_news/models/parser.dart';
import 'package:flutter_rss_news/widgets/loading.dart';
import 'package:webfeed/webfeed.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rss_news/widgets/styledText.dart';
import 'package:flutter_rss_news/widgets/news.dart';

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
      ),
      body: choixDuBody(),
    );
  }

  Widget choixDuBody() {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (feed == null) {
      return Center(
        child: Loading(),
      );
    } else {
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
          readNews(item);
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
                    StyledText(publishedDateToString(item.pubDate), color: Colors.grey[500],  factor: 0.8, textAlign: TextAlign.center),
                    StyledText(item.title, color: Colors.deepOrange, factor: 1.6, textAlign: TextAlign.left),
                    Padding(padding: EdgeInsets.all(10.0)),
                    StyledText(item.description, color: Colors.black, factor: 1.1, textAlign: TextAlign.justify),
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
                onTap: (() => print('Tapped grid')),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        height: 90.0,
                        width: MediaQuery.of(context).size.width - 20.0,
                        fit: BoxFit.cover,
                        image: NetworkImage(item.enclosure.url),
                      ),
                      Padding(padding: EdgeInsets.all(4.0),),
                      StyledText(item.title, color: Colors.deepOrange, factor: 1.0, textAlign: TextAlign.left),
                      Padding(padding: EdgeInsets.all(4.0),),
                      StyledText(publishedDateToString(item.pubDate), color: Colors.grey[500], factor: 0.6, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  // Convert pubDate into "Publié il y a X minutes/heures/jours"
  String publishedDateToString(string) {
    // DateFormat for Le Monde
    DateFormat dateFormat = DateFormat("E, d MMM yyyy HH:mm:ss");
    DateTime dateTime = dateFormat.parse(string);
    int result = DateTime.now().difference(dateTime).inMinutes;
    if (result >= 2880) {
      return "Publié il y a ${(result / 1440).floor()} jours";
    } else if (result >= 1440) {
      return "Publié il y a ${(result / 1440).floor()} jour";
    } else if (result >= 120) {
      return "Publié il y a ${(result / 60).floor()} heures et ${result % 60} minutes";
    } else if (result >= 60) {
      return "Publié il y a ${(result / 60).floor()} heure et ${result % 60} minutes";
    } else {
      return "Publié il y a $result minutes}";
    }
  }

  void readNews(RssItem item) {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return News();
   }));
  }
}
