import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart';
import 'dart:async';

class Parser {

  final url = "https://www.lemonde.fr/planete/rss_full.xml";

  Future loadRSS() async {
    final response = await get(url);
    if (response.statusCode == 200) {
      final feed = RssFeed.parse(response.body); // for parsing RSS feed
      return feed;
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}