import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda_news/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class AuthenticationProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Instantiate Firestore
  String? _userId;
  String? _errorMessage;
  bool _isLoading = false;

  String? get userId => _userId;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true; // Set loading to true
    notifyListeners();

    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _userId = user.uid; // Store user ID
        _errorMessage = null; // Clear any previous error
        return true; // Successful login
      }
    } catch (e) {
      _errorMessage = _handleAuthError(e); // Assign user-friendly error message
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners();
    }

    return false; // Return false if login failed
  }

  Future<bool> signUp(String email, String password, String username) async {
    _isLoading = true; // Set loading to true
    notifyListeners();

    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        _userId = user.uid; // Store user ID
        _errorMessage = null; // Clear any previous error

        // Store user details in Firestore
        await _firestore.collection('users').doc(_userId).set({
          'email': email,
          'username': username,
          'createdAt': DateTime.now().toIso8601String(),
        });

        return true; // Successful signup
      }
    } catch (e) {
      _errorMessage = _handleAuthError(e); // Assign user-friendly error message
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners();
    }

    return false; // Return false if signup failed
  }

  void logout() {
    _userId = null; // Clear user ID
    notifyListeners();
  }

  // Handle Firebase authentication errors
  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'invalid-credential':
          return 'The credentials you provided are invalid. Please check and try again.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        default:
          return 'An unknown error occurred. Please try again.';
      }
    }
    return 'An error occurred. Please try again.'; // Fallback error message
  }
}
