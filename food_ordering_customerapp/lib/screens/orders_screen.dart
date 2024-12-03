import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/services/order_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Orders'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: StreamBuilder(
            stream: OrderService().getOrders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List orderList = snapshot.data!;
                return SizedBox(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        var order = snapshot.data![index];
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              tileColor:
                                  const Color.fromARGB(255, 106, 106, 106),
                              leading: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              title: Text(
                                "Total: Rs.${order.totalPrice.toString()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  '${order.date.day}/${order.date.month}/${order.date.year}'),
                              trailing: Text(
                                order.status,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                      itemCount: orderList.length),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
