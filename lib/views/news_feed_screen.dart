// lib/views/news_feed_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../constants/app_styles.dart';
import '../widgets/news_body.dart'; // Import the NewsBody widget
import '../providers/news_provider.dart'; // Import the NewsProvider

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          NewsProvider()..fetchNews('us'), // Initialize and fetch news
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.primaryColor,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'MyNews',
              style: AppStyles.boldText.copyWith(color: AppStyles.lightColor),
            ),
          ),
          actions: [
            Row(
              children: [
                Transform.rotate(
                  angle: 0.786,
                  child: const Icon(
                    Icons.navigation,
                    color: AppStyles.lightColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'US',
                    style: AppStyles.boldText.copyWith(
                      color: AppStyles.lightColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          color: AppStyles.greyColor,
          child: const NewsBody(),
        ),
      ),
    );
  }
}
