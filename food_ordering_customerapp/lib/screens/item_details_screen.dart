import 'dart:developer';

import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/layout.dart';
import 'package:food_ordering_customerapp/models/menu_item.dart';
import 'package:food_ordering_customerapp/provider/order_provider.dart';
import 'package:food_ordering_customerapp/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class ItemDetailsScreen extends StatefulWidget {
  final MenuItem item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Item Details'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Layout(index: 2,)));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      bottomSheet: Container(
        color: const Color.fromARGB(255, 244, 122, 1),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (quantity > 0) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(quantity.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    provider.addItemToOrder(context, widget.item, quantity);
                  },
                  child: Text("Add to Cart")),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.item.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.item.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Rs.${widget.item.price.toString()}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.item.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
