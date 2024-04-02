// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String?> getCurrentUser();
  Future<String?> signOut();
}

class Auth implements AuthImplementation {
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
