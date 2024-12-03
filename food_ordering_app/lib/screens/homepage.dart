import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/menu_items_screen.dart';
import 'package:food_ordering_app/screens/orders_screen.dart';

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
                'HungryHub Foods Admin Panel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 123, 0),
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
                            builder: (context) => const MenuItemsScreen()),
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
                            builder: (context) => const OrdersScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Orders"),
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
