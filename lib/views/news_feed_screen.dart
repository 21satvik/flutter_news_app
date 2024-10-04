import 'package:flutter/material.dart';
import '../constants/app_styles.dart';
import '../widgets/news_card.dart'; // Import the NewsCard widget

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'MyNews',
            style: AppStyles.boldText.copyWith(
              color: AppStyles.lightColor,
              fontSize:
                  screenWidth * 0.05, // Responsive font size for the title
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Transform.rotate(
                angle: 0.786,
                child: Icon(
                  Icons.navigation,
                  color: AppStyles.lightColor,
                  size: screenWidth * 0.05, // Responsive icon size
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.04), // Responsive padding
                child: Text(
                  'IN',
                  style: AppStyles.boldText.copyWith(
                    color: AppStyles.lightColor,
                    fontSize:
                        screenWidth * 0.045, // Responsive font size for IN
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: AppStyles.greyColor,
        child: const MyNewsBody(),
      ),
    );
  }
}

class MyNewsBody extends StatelessWidget {
  const MyNewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              "Top Headlines",
              style: AppStyles.boldText.copyWith(
                color: Colors.black,
                fontSize: screenWidth * 0.05, // Responsive font size
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                  height: screenWidth * 0.04)), // Responsive vertical space
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const NewsCard(); // Use the imported NewsCard widget
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
