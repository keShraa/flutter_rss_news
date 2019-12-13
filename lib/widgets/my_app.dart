import 'package:flutter/material.dart';
import 'package:flutter_rss_news/widgets/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News - RSS',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(title: 'Latest News'),
    );
  }
}
