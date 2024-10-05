import 'package:flutter/material.dart';
import 'package:lingopanda_news/providers/region_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_styles.dart';
import '../widgets/news_body.dart';
import '../providers/news_provider.dart';
import '../widgets/app_drawer.dart';

/// NewsFeedScreen displays news articles based on the selected region.
class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final regionProvider = Provider.of<RegionProvider>(context);
    final selectedRegion = regionProvider.selectedRegion;

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
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/region_selection');
            },
            icon: Transform.rotate(
              angle: 0.786,
              child: const Icon(
                Icons.navigation,
                color: AppStyles.lightColor,
                size: 20,
              ),
            ),
            label: Text(
              selectedRegion.isNotEmpty
                  ? selectedRegion.toUpperCase()
                  : 'Select Region',
              style: AppStyles.boldText.copyWith(
                color: AppStyles.lightColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: selectedRegion.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ChangeNotifierProvider(
              create: (_) => NewsProvider()..fetchNews(selectedRegion),
              child: Container(
                color: AppStyles.greyColor,
                child: const NewsBody(),
              ),
            ),
    );
  }
}
