import 'package:food_ordering_customerapp/models/order_item.dart';

class OrderModel {
  final String? id;
  final String uid;
  final String name;
  final String address;
  final String phone;
  final double totalPrice;
  final List<OrderItem> order;
  final String status;
  final DateTime date;

  OrderModel({
    this.id,
    required this.uid,
    required this.name,
    required this.address,
    required this.phone,
    required this.order,
    required this.totalPrice,
    required this.status,
    required this.date,
  });
}
