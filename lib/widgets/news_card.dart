import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04), // 4% of screen width
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(
            screenWidth * 0.03), // Padding responsive to screen size
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "News Source",
                    style: AppStyles.boldText.copyWith(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045, // Responsive font size
                    ),
                  ),
                  SizedBox(
                      height:
                          screenWidth * 0.02), // Responsive vertical spacing
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel sapien tellus. Ut ...",
                    style: AppStyles.mediumText.copyWith(
                      color: Colors.black,
                      fontSize: screenWidth * 0.04, // Responsive font size
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    "10 min ago",
                    style: AppStyles.regularText.copyWith(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.035, // Responsive font size
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: screenWidth * 0.04), // Responsive horizontal spacing
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://via.placeholder.com/80x80.png?text=BREAKING+NEWS',
                height: screenWidth * 0.2, // 20% of screen width for height
                width: screenWidth * 0.2, // 20% of screen width for width
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
