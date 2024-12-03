import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/order_model.dart';
import 'package:food_ordering_app/services/order_service.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderModel order;
  late String newStatus;

  @override
  void initState() {
    super.initState();
    order = widget.order;
    newStatus = order.status;
  }

  List statusList = ["pending", "processing", "delivered", "cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer Name: ${order.name}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Order ID: ${order.id}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text('Address: ${order.address}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Phone: ${order.phone}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Total Price: \Rs.${order.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Date: ${order.date.toLocal()}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Status:    ', style: TextStyle(fontSize: 17)),
                  DropdownButton<String>(
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          newStatus = newValue;
                        });
                        OrderService().editOrder(context, order.id, newValue);
                      }
                    },
                    items: statusList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: newStatus,
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Order Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: order.order.length,
                  itemBuilder: (context, index) {
                    final item = order.order[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Image.network(item.item.image,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(item.item.name),
                      subtitle: Text(
                          '${item.quantity} x \Rs.${item.item.price.toStringAsFixed(2)}'),
                      trailing: Text(
                        '\Rs.${item.itemTotalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
