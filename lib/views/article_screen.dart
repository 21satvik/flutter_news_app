import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_styles.dart';
import '../models/news_article.dart';

/// A screen to display a detailed view of a news article.
///
/// The [ArticleScreen] shows the full article content, including an image,
/// title, source, description, and a link to read the full article in the
/// browser.
class ArticleScreen extends StatelessWidget {
  /// The article to be displayed on this screen.
  final NewsArticle article;

  /// Constructs an [ArticleScreen] with a required [article] parameter.
  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'MyNews',
            style: AppStyles.boldText.copyWith(color: AppStyles.lightColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.imageUrl ??
                      'https://img.freepik.com/premium-vector/breaking-news-world-map-background_23-2148506384.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenWidth * 0.5,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Displays the source of the article.
              Text(
                article.source,
                style: AppStyles.boldText.copyWith(
                    fontSize: screenWidth * 0.04), // Responsive font size
              ),
              const SizedBox(height: 4),
              // Displays the publication date of the article.
              Text(
                article.pubDate,
                style: AppStyles.regularText.copyWith(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.035, // Responsive font size
                ),
              ),
              const SizedBox(height: 16),
              // Displays the title of the article.
              Text(
                article.title,
                style: AppStyles.boldText.copyWith(
                    fontSize: screenWidth * 0.05), // Responsive font size
              ),
              const SizedBox(height: 8),
              // Displays the description of the article, if available.
              Text(
                article.description ?? '',
                style: AppStyles.regularText.copyWith(
                    fontSize: screenWidth * 0.045), // Responsive font size
              ),
              const SizedBox(height: 16),
              // A button to open the full article in the browser.
              TextButton(
                onPressed: () async {
                  // Attempts to launch the article's link in the browser.
                  final Uri url = Uri.parse(article.link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.inAppWebView,
                    );
                  } else {
                    // Throws an error if the link could not be launched.
                    throw 'Could not launch $url';
                  }
                },
                child: const Text("Read Full Article"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
