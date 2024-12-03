import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

int quantity = 0;

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
