import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RegionProvider with ChangeNotifier {
  String _selectedRegion = ''; // Start with an empty value

  String get selectedRegion => _selectedRegion;

  RegionProvider() {
    fetchRegion(); // Fetch region when the provider is created
  }

  // Method to fetch the region from Remote Config
  Future<void> fetchRegion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    // Set default values for remote config parameters
    await remoteConfig.setDefaults({'region': 'US'});

    try {
      // Fetch the remote config
      await remoteConfig.fetchAndActivate();

      // Update the selected region from remote config
      _selectedRegion = remoteConfig.getString('region');
      debugPrint('Selected Region: $_selectedRegion');
    } catch (e) {
      debugPrint('Failed to fetch remote config: $e'); // Handle any errors
    } finally {
      notifyListeners();
    }
  }

  // Method to select a region
  Future<void> selectRegion(String region) async {
    _selectedRegion = region;
    notifyListeners();
  }
}
