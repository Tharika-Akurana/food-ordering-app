import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/homepage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "lib/assets/images/logo.png",
              height: 300,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text("Your Favourite Food delivery Partner",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.yellow)),
          ],
        ),
      ),
    );
  }
}
