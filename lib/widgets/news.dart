import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss_news/widgets/styledText.dart';

class News extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _News();
}

class _News extends State<News> {

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Latest News - Article"),
      ),
      body: new Center(
        child: styledNews(index),
      ),
    );
  }


  Widget styledNews(index) {
    double _size = MediaQuery.of(context).size.width * 0.75;

    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image(
          height: 160.0,
          width: MediaQuery.of(context).size.width - 20.0,
          fit: BoxFit.cover,
          image: NetworkImage("https://www.itsmfusa.org/resource/resmgr/images/more_images/news-3.jpg"),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              StyledText("date", color: Colors.grey[500], factor: 0.8, textAlign: TextAlign.center),
              StyledText("title", color: Colors.deepOrange, factor: 1.6, textAlign: TextAlign.left),
              Padding(padding: EdgeInsets.all(10.0)),
              StyledText("description", color: Colors.black, factor: 1.1, textAlign: TextAlign.justify),
            ],
          ),
        ),
      ],
    );
  }

}