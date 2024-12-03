import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/layout.dart';
import 'package:food_ordering_customerapp/screens/menu_items_screen.dart';
import 'package:food_ordering_customerapp/screens/orders_screen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Image.asset(
                "lib/assets/images/logo.png",
                height: 200,
              ),
              const SizedBox(height: 30),
              const Text(
                'Welcome to HungryHub Foods',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 123, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'At HungryHub, we offer a wide variety of delicious meals made from the freshest ingredients. Our mission is to provide you with an exceptional dining experience.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(136, 212, 212, 212),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Layout(index: 1)),
                      );
                    },
                    icon: const Icon(Icons.restaurant_menu),
                    label: const Text("Food Menu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 123, 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Layout(index: 3)),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("My Orders"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 123, 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
