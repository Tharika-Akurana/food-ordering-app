import 'package:food_ordering_app/models/menu_item.dart';

class OrderItem {
  final MenuItem item;
  final int quantity;

  final double itemTotalPrice;
  
  OrderItem({
    required this.item,
    required this.quantity,
    required this.itemTotalPrice,
  });
}
