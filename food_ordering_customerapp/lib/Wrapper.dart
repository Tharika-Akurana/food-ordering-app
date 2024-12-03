import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/layout.dart';
import 'package:food_ordering_customerapp/screens/user/login_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error occured: ${snapshot.error}"),
              );
            } else {
              if (snapshot.data == null) {
                return const LoginScreen();
              }  else {
                return Layout();
              }
            }
          }),
    );
  }
}
