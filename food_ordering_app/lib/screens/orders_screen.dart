import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/order_details_screen.dart';
import 'package:food_ordering_app/services/order_service.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String statusToShow = "pending";
  List statusList = ["pending", "processing", "delivered", "cancelled"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Orders'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: StreamBuilder(
            stream: OrderService().getOrders(statusToShow),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List orderList = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              statusToShow = newValue;
                            });
                          }
                        },
                        items: statusList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                        value: statusToShow,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var order = snapshot.data![index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailsScreen(
                                            order: order,
                                          ),
                                        ));
                                  },
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    tileColor: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    leading: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    title: Text(
                                      order.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "Total: Rs.${order.totalPrice.toString()}"),
                                    trailing: Text(
                                      '${order.date.day}/${order.date.month}/${order.date.year}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                          itemCount: orderList.length),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
