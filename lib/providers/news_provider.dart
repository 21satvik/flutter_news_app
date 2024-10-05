import 'package:flutter/material.dart';

import '../models/news_article.dart';
import '../services/news_service.dart';

/// NewsProvider class manages the state of news articles
/// and fetches news data from the NewsService.
class NewsProvider with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches news articles based on the provided country code.
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
