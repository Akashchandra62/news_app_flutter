import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final int views;
  final DateTime createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.views,
    required this.createdAt,
  });

  static List<Article> articles = [];

  @override
  String toString() {
    return 'Article{ id: $id ,title: $title,subtitle: $subtitle, body: $body, '
        'category: $category, createdAt: $createdAt, '
        'imageUrl: $imageUrl}';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        body,
        author,
        authorImageUrl,
        category,
        imageUrl,
        views,
        createdAt,
      ];

  Future<void> fetchNews() async {
    String rssUrl =
        'https://timesofindia.indiatimes.com/rssfeedstopstories.cms';
    var response = await http.get(Uri.parse(rssUrl));

    if (response.statusCode == 200) {
      var rawXml = response.body;
      var xml2Json = Xml2Json();

      // Parse the XML data to JSON
      xml2Json.parse(rawXml);
      var jsonString = xml2Json.toOpenRally();

      List<dynamic> jsonData =
          json.decode(jsonString)['rss']['channel']['item'];

      List<Article> newsItems = [];
      int idCounter = 1;

      for (var item in jsonData) {
        String title = item['title'];
        String description = item['description'];
        String link = item['link'];
        String pubDateString = item['pubDate'];
        DateTime pubDate =
            DateFormat('EEE, dd MMM yyyy HH:mm:ss Z').parse(pubDateString);
        String enclosure = item['enclosure']['url'];

        Article newsItem = Article(
            id: idCounter.toString(),
            title: title,
            body: description,
            author: "AKash",
            authorImageUrl: enclosure,
            subtitle: link,
            createdAt: pubDate,
            imageUrl: enclosure,
            views: 40,
            category: "Politics");
        idCounter++;
        newsItems.add(newsItem);
      }
      articles = newsItems;
      print(articles[0]);
    } else {
      print("Error in fetching the news");
    }
  }
}
