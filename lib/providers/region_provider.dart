import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

/// RegionProvider class manages the selected region for news articles
/// and fetches region data from Firebase Remote Config.
class RegionProvider with ChangeNotifier {
  String _selectedRegion = '';

  String get selectedRegion => _selectedRegion;

  RegionProvider() {
    fetchRegion();
  }

  /// Fetches the region from Firebase Remote Config.
  Future<void> fetchRegion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setDefaults({'region': 'US'});

    try {
      await remoteConfig.fetchAndActivate();
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
