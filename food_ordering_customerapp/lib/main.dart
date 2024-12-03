import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/assets/theme/theme.dart';
import 'package:food_ordering_customerapp/firebase_options.dart';
import 'package:food_ordering_customerapp/provider/order_provider.dart';
import 'package:food_ordering_customerapp/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OrderProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hungry Hub',
          theme: darkMode,
          home: const SafeArea(child: WelcomeScreen())),
    );
  }
}
