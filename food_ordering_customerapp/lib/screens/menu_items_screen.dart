import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/models/menu_item.dart';
import 'package:food_ordering_customerapp/screens/cart_screen.dart';
import 'package:food_ordering_customerapp/screens/item_details_screen.dart';
import 'package:food_ordering_customerapp/services/menu_item_service.dart';

class MenuItemsScreen extends StatefulWidget {
  const MenuItemsScreen({super.key});

  @override
  State<MenuItemsScreen> createState() => _MenuItemsScreenState();
}

class _MenuItemsScreenState extends State<MenuItemsScreen> {
  final _menuItemInstance = MenuItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Our Menu'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
              stream: _menuItemInstance.getAllMenuItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MenuItem> menuItems = snapshot.data!;
                  return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: menuItems.map((item) {
                        return GestureDetector(
                          onTap: () {
                            //navigate to item details screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetailsScreen(item: item)));
                          },
                          child: Card(
                            elevation: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(item.image,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Rs. ${item.price.toString()}")
                              ],
                            ),
                          ),
                        );
                      }).toList());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 17, 255, 112),
                    ),
                  );
                }
              }),
        ));
  }
}
