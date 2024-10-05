import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  final String apiKey = dotenv.env['NEWSAPI_KEY'] ?? '';
  final String baseUrl = 'https://newsdata.io/api/1/latest';

  Future<List<NewsArticle>> fetchTopHeadlines(String country) async {
    final response = await http
        .get(Uri.parse('$baseUrl?country=$country&language=en&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<NewsArticle> articles = (jsonData['results'] as List)
          .map((article) => NewsArticle.fromJson(article))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
