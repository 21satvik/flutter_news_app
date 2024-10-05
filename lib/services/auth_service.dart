import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Log the error and rethrow
      debugPrint('Error during sign up: ${e.message}');
      rethrow;
    }
  }

  // Login with email and password
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Log the error and rethrow
      debugPrint('Error during login: ${e.message}');
      rethrow;
    }
  }

  // Logout the current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
      debugPrint('User logged out successfully');
    } catch (e) {
      // Log error if sign out fails
      debugPrint('Error during logout: ${e.toString()}');
      rethrow;
    }
  }

  // Get current authenticated user
  User? get currentUser {
    return _auth.currentUser;
  }
}
