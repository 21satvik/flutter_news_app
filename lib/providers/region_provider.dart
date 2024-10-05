import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:convert'; // Import for jsonDecode

/// RegionProvider class manages the selected region for news articles
/// and fetches region data from Firebase Remote Config.
class RegionProvider with ChangeNotifier {
  String _selectedRegion = '';
  Map<String, String> _regions = {}; // Map to hold all available regions

  String get selectedRegion => _selectedRegion;
  Map<String, String> get regions => _regions; // Getter for regions

  RegionProvider() {
    fetchRegion();
  }

  /// Fetches the region and all available regions from Firebase Remote Config.
  Future<void> fetchRegion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    final settings = RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(seconds: 60),
    );

    // Apply the new settings
    await remoteConfig.setConfigSettings(settings);

    await remoteConfig
        .setDefaults({'region': 'US', 'countries': '{"US": "United States"}'});
    try {
      await remoteConfig.fetchAndActivate();

      // Get and decode the countries JSON
      final countriesJson = remoteConfig.getString('countries');
      // Check if countriesJson is not empty before decoding
      if (countriesJson.isNotEmpty) {
        _regions = Map<String, String>.from(jsonDecode(countriesJson));
      } else {
        debugPrint('Countries JSON is empty.');
      }
      debugPrint('Available Regions: $_regions');

      _selectedRegion = remoteConfig.getString('region');
      debugPrint('Selected Region: $_selectedRegion');
    } catch (e) {
      debugPrint('Failed to fetch remote config: $e');
    } finally {
      notifyListeners();
    }
  }

  /// Updates the selected region.
  Future<void> selectRegion(String region) async {
    _selectedRegion = region;
    notifyListeners();
  }
}
