import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
// import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/screens.dart';

class NewsItem {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String category;
  final String imageUrl;
  final DateTime createdAt;
  final String author;
  final String authorImageUrl;
  final int views;

  NewsItem({
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

  @override
  String toString() {
    return 'NewsItem{ id: $id ,title: $title,subtitle: $subtitle, body: $body, '
        'category: $category, createdAt: $createdAt, '
        'imageUrl: $imageUrl}';
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  List<Article> newsList = [];
  Article newsRepository = Article(
    id: 'article_id', // Provide a unique identifier for the article
    title: 'Article Title',
    subtitle: 'Subtitle',
    body: 'Article body text...',
    author: 'Author Name',
    authorImageUrl: 'https://example.com/author-image.jpg',
    category: 'News Category',
    imageUrl: 'https://example.com/article-image.jpg',
    views: 100,
    createdAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    await newsRepository
        .fetchNews(); // Use the fetchNews method from NewsRepository

    setState(() {
      // Update the newsList with the fetched news items
      newsList = Article.articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        DiscoverScreen.routeName: (context) => const DiscoverScreen(),
        ArticleScreen.routeName: (context) => const ArticleScreen(),
      },
    );
  }
}
