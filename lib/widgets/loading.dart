import 'package:flutter/material.dart';
import 'package:flutter_rss_news/widgets/styledText.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.style, color: Colors.deepOrange, size: 100.0,),
          Padding(padding: EdgeInsets.all(20.0),),
          StyledText("Chargement en cours...", factor: 2.2),
        ],
      ),
    );
  }
}