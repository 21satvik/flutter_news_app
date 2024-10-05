// lib/providers/news_provider.dart
import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNews(String countryCode) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await NewsService().fetchTopHeadlines(countryCode);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
