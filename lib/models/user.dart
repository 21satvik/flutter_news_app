import 'package:cloud_firestore/cloud_firestore.dart';

/// User class representing a user with attributes such as name, email, region, and account creation date.
class User {
  final String name;
  final String email;
  final DateTime accountCreated;

  User({
    required this.name,
    required this.email,
    required this.accountCreated,
  });

  /// Factory constructor to create a User instance from Firestore data.
  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      name: data['username'] ?? 'Guest',
      email: data['email'] ?? '',
      accountCreated: (data['accountCreated'] as Timestamp).toDate(),
    );
  }
}
