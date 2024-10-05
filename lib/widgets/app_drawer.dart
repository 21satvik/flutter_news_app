import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda_news/constants/app_styles.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import '../models/user.dart';

/// AppDrawer displays user-related information and option to log-out
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
                  decoration:
                      const BoxDecoration(color: AppStyles.primaryColor),
                  child: const Text(
                    'Error loading user',
                    style: TextStyle(
                      color: AppStyles.lightColor,
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
                  color: AppStyles.primaryColor,
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
                leading:
                    const Icon(Icons.logout, color: AppStyles.secondaryColor),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  authProvider.logout(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
