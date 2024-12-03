import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/models/menu_item.dart';
import 'package:food_ordering_customerapp/models/order_item.dart';

class OrderProvider extends ChangeNotifier {
  final List _orderItems = [];
  UnmodifiableListView get orderItems => UnmodifiableListView(_orderItems);

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

//Add items to the order list
  addItemToOrder(
    BuildContext context,
    MenuItem item,
    int quantity,
  ) {
    double itemTotalPrice = item.price * quantity;

    _orderItems.add(
      OrderItem(
        item: item,
        quantity: quantity,
        itemTotalPrice: itemTotalPrice,
      ),
    );

    _totalPrice += itemTotalPrice;
    notifyListeners;
ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added to the cart'),
          ),
        );
    log(_orderItems.toString());
    log(quantity.toString());
  }

//Remove items from the order list
  removeItemFromOrder(OrderItem item) {
    _orderItems.removeWhere((element) => element.item == item.item);
    _totalPrice -= item.itemTotalPrice;
    notifyListeners();
  }

  //Clear the Order
  clearTheOrder() {
    _orderItems.clear();
    _totalPrice = 0;
    notifyListeners();
  }
}
