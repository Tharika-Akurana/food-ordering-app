import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/models/menu_item.dart';
import 'package:food_ordering_customerapp/models/order_item.dart';
import 'package:food_ordering_customerapp/models/order_model.dart';
import 'package:food_ordering_customerapp/provider/order_provider.dart';
import 'package:food_ordering_customerapp/services/user_service.dart';
import 'package:provider/provider.dart';

class OrderService {
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  User? user = FirebaseAuth.instance.currentUser;
  //create service
  Future createOrder(
    context,
  ) async {
    try {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      final userDetails = await UserService().fetchUserDetails();

      if (userDetails == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                Text('Please update your profile  to place an order'),
              ],
            ),
          ),
        );
        return;
      }

      DocumentReference orderDoc = await orderCollection.add({
        'uid': user?.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
        'name': userDetails['userName'],
        'phone': userDetails['mobile'],
        'address': userDetails['address'],
        'totalPrice': orderProvider.totalPrice
      });
      for (var orderItem in orderProvider.orderItems) {
        await orderDoc.collection("menuItems").add({
          'name': orderItem.item.name,
          'price': orderItem.item.price,
          'quantity': orderItem.quantity,
          'image': orderItem.item.image,
          'description': orderItem.item.description,
          'itemTotalPrice': orderItem.itemTotalPrice,
        });
      }
      orderProvider.clearTheOrder();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order placed successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create order'),
        ),
      );
    }
  }

  //Get user orders
  Stream<List<OrderModel>> get getOrders {
    return orderCollection
        .where('uid', isEqualTo: user?.uid)
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
}
