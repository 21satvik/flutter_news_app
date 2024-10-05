import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda_news/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _userId;
  String? _errorMessage;
  bool _isLoading = false;
  Map<String, dynamic>? _userData; // Variable to hold user data

  AuthenticationProvider() {
    _initializeUser(); // Check if user is already logged in
  }

  String? get userId => _userId;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData; // Getter for user data

  Future<void> _initializeUser() async {
    User? user =
        _authService.currentUser; // Get the current user from AuthService
    if (user != null) {
      _userId = user.uid; // Set the userId if logged in
      await fetchUserData(); // Fetch user data after initialization
      notifyListeners();
    }
  }

  Future<void> fetchUserData() async {
    if (_userId == null) return; // If no user ID, exit the method
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(_userId).get();
      _userData = snapshot.data() as Map<String, dynamic>?; // Store user data
      notifyListeners(); // Notify listeners about data change
    } catch (e) {
      print('Error fetching user data: $e'); // Handle any errors
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _userId = user.uid;
        _errorMessage = null;
        await fetchUserData(); // Fetch user data on login
        return true;
      }
    } catch (e) {
      _errorMessage = _handleAuthError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return false;
  }

  Future<bool> signUp(String email, String password, String username) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        _userId = user.uid;
        _errorMessage = null;

        await _firestore.collection('users').doc(_userId).set({
          'email': email,
          'username': username,
          'createdAt': DateTime.now().toIso8601String(),
        });

        await fetchUserData(); // Fetch user data on signup
        return true;
      }
    } catch (e) {
      _errorMessage = _handleAuthError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return false;
  }

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    _userId = null; // Clear user ID
    _userData = null; // Clear user data
    notifyListeners();

    // Navigate to login screen after logout
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'invalid-credential':
          return 'The credentials you provided are invalid. Please check and try again.';
        default:
          return 'An unknown error occurred. Please try again.';
      }
    }
    return 'An error occurred. Please try again.';
  }
}
