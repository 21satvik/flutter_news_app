import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_styles.dart';
import '../providers/news_provider.dart';
import './news_card.dart';

/// NewsBody displays the list of news articles with a loading indicator, error message, or a message if no articles are found.
class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (newsProvider.errorMessage != null) {
            return Center(child: Text('Error: ${newsProvider.errorMessage}'));
          }

          if (newsProvider.articles.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }

          final articles = newsProvider.articles;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  "Top Headlines",
                  style: AppStyles.boldText.copyWith(color: Colors.black),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final article = articles[index];
                    return NewsCard(article: article);
                  },
                  childCount: articles.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
