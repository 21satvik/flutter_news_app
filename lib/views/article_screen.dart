import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_styles.dart';
import '../models/news_article.dart';

class ArticleScreen extends StatelessWidget {
  final NewsArticle article;

  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive design
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
          padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.imageUrl ??
                      'https://img.freepik.com/premium-vector/breaking-news-world-map-background_23-2148506384.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenWidth * 0.5, // Responsive height
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
              // Article Details
              Text(
                article.source,
                style: AppStyles.boldText.copyWith(
                    fontSize: screenWidth * 0.04), // Responsive font size
              ),
              const SizedBox(height: 4),
              Text(
                article.pubDate,
                style: AppStyles.regularText.copyWith(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.035, // Responsive font size
                ),
              ),
              const SizedBox(height: 16),
              // Article Title
              Text(
                article.title,
                style: AppStyles.boldText.copyWith(
                    fontSize: screenWidth * 0.05), // Responsive font size
              ),
              const SizedBox(height: 8),
              // Article Description
              Text(
                article.description ?? '',
                style: AppStyles.regularText.copyWith(
                    fontSize: screenWidth * 0.045), // Responsive font size
              ),
              const SizedBox(height: 16),
              // Link to the article
              TextButton(
                onPressed: () async {
                  // Implement navigation to full article URL
                  final Uri url = Uri.parse(article.link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.inAppWebView,
                    );
                  } else {
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
