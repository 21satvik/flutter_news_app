import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda_news/constants/app_styles.dart';
import '../providers/authentication_provider.dart'; // Import AuthProvider
import '../providers/region_provider.dart'; // Import RegionProvider
import '../models/user.dart'; // Import User model
import 'package:provider/provider.dart'; // Import Provider package

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final String? userId = authProvider.userId;

    return Drawer(
      child: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0c548e), // Primary color
                  ),
                  child: const Text(
                    'Error loading user',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            );
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>?;
          final user = User.fromFirestore(userData!); // Create a User instance

          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppStyles.primaryColor, // Primary color
                ),
                child: Text(
                  'Hello, ${user.name}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout,
                    color: Color(0xFF303F60)), // Secondary color
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  authProvider.logout(context); // Call the logout function
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
