/// User class representing a user with attributes such as name and email.
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  /// Factory constructor to create a User instance from Firestore data.
  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      name: data['username'] ?? 'Guest',
      email: data['email'] ?? '',
    );
  }
}
