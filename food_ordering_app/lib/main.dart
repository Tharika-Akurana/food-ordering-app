import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/assets/theme/theme.dart';
import 'package:food_ordering_app/firebase_options.dart';
import 'package:food_ordering_app/screens/homepage.dart';
import 'package:food_ordering_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hungry Hub',
        theme: darkMode,
        home: const SafeArea(child: WelcomeScreen()));
  }
}
