import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/menu_item.dart';
import 'package:food_ordering_app/models/order_item.dart';
import 'package:food_ordering_app/models/order_model.dart';

class OrderService {
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  //Get user orders
  Stream<List<OrderModel>>  getOrders(String status) {
    return orderCollection.where('status', isEqualTo: status)
        .snapshots()
        .asyncMap((snapshot) => _orderListFromSnapshot(snapshot));
  }

  Future<List<OrderModel>> _orderListFromSnapshot(
      QuerySnapshot snapshot) async {
    return await Future.wait(snapshot.docs.map((doc) async {
      List<OrderItem> orderItems = [];
      QuerySnapshot orderItemsSnapshot =
          await doc.reference.collection('menuItems').get();

      for (var orderItem in orderItemsSnapshot.docs) {
        orderItems.add(OrderItem(
          item: MenuItem(
            name: orderItem['name'],
            price: orderItem['price'],
            image: orderItem['image'],
            description: orderItem['description'],
          ),
          quantity: orderItem['quantity'],
          itemTotalPrice: orderItem['itemTotalPrice'],
        ));
      }

      return OrderModel(
        id: doc.id,
        uid: doc['uid'],
        name: doc['name'],
        address: doc['address'],
        phone: doc['phone'],
        order: orderItems,
        totalPrice: doc['totalPrice'],
        status: doc['status'],
        date: doc['createdAt'].toDate(),
      );
    }).toList());
  }

  //Update the order status
  Future editOrder(context, orderId, newStatus) async {
    try{
      await orderCollection.doc(orderId).update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Status updated successfully"), backgroundColor: Colors.green));
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error in updating status"), backgroundColor: Colors.red));
    }
  }
}
