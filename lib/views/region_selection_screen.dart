import 'package:flutter/material.dart';
import 'package:lingopanda_news/providers/region_provider.dart';
import 'package:provider/provider.dart';
import '../constants/available_regions.dart';

class RegionSelectorScreen extends StatelessWidget {
  const RegionSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final regionProvider = Provider.of<RegionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Region'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: AvailableRegions.regions.length,
          itemBuilder: (context, index) {
            final regionCode = AvailableRegions.regions.keys.elementAt(index);
            final regionName = AvailableRegions.regions[regionCode]!;

            return GestureDetector(
              onTap: () {
                regionProvider.selectRegion(regionCode); // Use the region code
                Navigator.of(context).pushReplacementNamed('/news_feed');
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Spacing between cards
                elevation: 4.0, // Card elevation
                child: Container(
                  padding: const EdgeInsets.all(16.0), // Padding inside card
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: regionProvider.selectedRegion == regionCode
                          ? Colors.blue
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      regionName, // Display full country name
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
