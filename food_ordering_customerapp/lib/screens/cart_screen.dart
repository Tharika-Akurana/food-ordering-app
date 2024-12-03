import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_ordering_customerapp/models/menu_item.dart';
import 'package:food_ordering_customerapp/models/order_item.dart';
import 'package:food_ordering_customerapp/provider/order_provider.dart';
import 'package:food_ordering_customerapp/services/order_service.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text('Cart'),
        ),
        body: Consumer<OrderProvider>(
          builder: (context, provider, child) {
            if (provider.orderItems.isEmpty) {
              return Center(child: Text('Your cart is empty'));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.orderItems.length,
                        itemBuilder: (context, index) {
                          OrderItem orderItem = provider.orderItems[index];
                          return Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      provider.removeItemFromOrder(orderItem);
                                    },
                                    label: 'Remove',
                                    backgroundColor: Colors.red,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                minVerticalPadding: 20,
                                leading: Image.network(
                                  orderItem.item.image,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(orderItem.item.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                trailing: Container(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Qty: ${orderItem.quantity}",
                                          style: const TextStyle(fontSize: 14)),
                                      Text('Rs.${orderItem.itemTotalPrice}',
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 92, 92, 92)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total: Rs.${provider.totalPrice}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        ElevatedButton(
                            onPressed: () {
                              OrderService().createOrder(context);
                            },
                            child: const Text('Place Order'))
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
