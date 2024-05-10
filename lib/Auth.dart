// ignore_for_file: unused_import

// Import necessary packages for Flutter and Firebase Authentication
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define an abstract class `AuthImplementation` to show authentication methods

abstract class AuthImplementation {
  // Method to sign in user with provided email and password
  Future<String> signIn(String email, String password);
  // Method to sign up user with provided email and password

  Future<String> signUp(String email, String password);

  // Method to get the ID of the current signed-in user

  Future<String?> getCurrentUser();

  // Method to sign out the current user

  Future<String?> signOut();
}

// Implement the `AuthImplementation` abstract class with concrete methods
class Auth implements AuthImplementation {
  // Firebase authentication instance
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential userCredentials =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials.user!.uid; // Access the uid from the User object
  }

  Future<String> signUp(String email, String password) async {
    UserCredential userCredentials =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials.user!.uid; // Access the uid from the User object
  }

  Future<String?> getCurrentUser() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null; // Return null if the user is not signed in
  }

  Future<String?> signOut() async {
    firebaseAuth.signOut();
    return null;
  }
}
