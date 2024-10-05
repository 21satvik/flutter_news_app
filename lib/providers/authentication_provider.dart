import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

/// AuthenticationProvider class manages user authentication and
/// user data retrieval, notifying listeners of state changes.
class AuthenticationProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _userId;
  String? _errorMessage;
  bool _isLoading = false;
  Map<String, dynamic>? _userData;

  AuthenticationProvider() {
    _initializeUser();
  }

  String? get userId => _userId;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData;

  /// Initializes user data if a user is already logged in.
  Future<void> _initializeUser() async {
    User? user = _authService.currentUser;
    if (user != null) {
      _userId = user.uid;
      await fetchUserData();
      notifyListeners();
    }
  }

  /// Fetches user data from Firestore using the user ID.
  Future<void> fetchUserData() async {
    if (_userId == null) return;
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(_userId).get();
      _userData = snapshot.data() as Map<String, dynamic>?;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  /// Handles user login and updates state accordingly.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _userId = user.uid;
        _errorMessage = null;
        await fetchUserData();
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

  /// Handles user signup and stores user information in Firestore.
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

        await fetchUserData();
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

  /// Logs out the current user and navigates to the login screen.
  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    _userId = null;
    _userData = null;
    notifyListeners();

    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  /// Handles authentication errors and returns corresponding messages.
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
