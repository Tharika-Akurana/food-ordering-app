import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

// User Register
  Future<User?> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credentials.user;
      log(user.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User created successfully"),
          backgroundColor: Colors.green));
      return user;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text((error as FirebaseAuthException).message.toString()),
          backgroundColor: Colors.red));
    }
    return null;
  }

// User login function
  Future<User?> loginUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User logged in successfully"),
          backgroundColor: Colors.green));
      return credentials.user;
    } catch (error) {
      log("something went wrong");
      log(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text((error as FirebaseAuthException).message.toString()),
          backgroundColor: Colors.red));
    }
    return null;
  }

//Forgot password
  Future sendresetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      log(error.toString());
    }
  }

//User signout function
  Future<void> userSignout(BuildContext context) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User logged out successfully"),
          backgroundColor: Colors.green));
    } catch (error) {
      log(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text((error as FirebaseAuthException).message.toString()),
          backgroundColor: Colors.red));
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // Initialize GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Clear any previous sign-in
      await googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Get auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
        throw Exception('Google Sign In failed');
      }

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with Firebase
      return await _auth.signInWithCredential(credential);
    } catch (error) {
      log('Google sign in error: ${error.toString()}');
      return null;
    }
  }
}
