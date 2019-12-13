import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:flutter_rss_news/widgets/styledText.dart';
import 'package:flutter_rss_news/widgets/convertDate.dart';

class ShowNew extends StatelessWidget {

  ShowNew(RssItem item) {
    this.item = item;
  }

  RssItem item;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News - Détail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: StyledText(item.title, color: Colors.deepOrange, factor: 1.6),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
            StyledText(ConvertDate().publishedDateToString(item.pubDate), color: Colors.grey[500],  factor: 0.8, textAlign: TextAlign.center),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
            Card(
              elevation: 4.0,
              child: Container(
                child: Image.network(item.enclosure.url, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: StyledText(item.description, color: Colors.black, factor: 1.1,),
            ),
          ],
        ),
      ),
    );
  }
}