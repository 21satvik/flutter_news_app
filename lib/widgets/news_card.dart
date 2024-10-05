import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

/// NewsCard displays an individual news article with its title, description, image, and other details.
class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String timeAgo;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.source,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source,
                    style: AppStyles.boldText.copyWith(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    title,
                    style: AppStyles.mediumText.copyWith(
                      color: Colors.black,
                      fontSize: screenWidth * 0.04,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    timeAgo,
                    style: AppStyles.regularText.copyWith(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: screenWidth * 0.2,
                width: screenWidth * 0.2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: screenWidth * 0.2,
                    width: screenWidth * 0.2,
                    color: Colors.grey,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
