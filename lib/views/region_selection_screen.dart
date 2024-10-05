import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/region_provider.dart';

/// RegionSelectorScreen allows users to select their news region.
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
          itemCount:
              regionProvider.regions.length, // Use the regions from provider
          itemBuilder: (context, index) {
            final regionCode = regionProvider.regions.keys.elementAt(index);
            final regionName = regionProvider.regions[regionCode]!;

            return GestureDetector(
              onTap: () {
                regionProvider.selectRegion(regionCode);
                Navigator.of(context).pushReplacementNamed('/news_feed');
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
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
                      regionName,
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
