import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/models/menu_item.dart';

class MenuItemService {
  final CollectionReference menuItemCollection =
      FirebaseFirestore.instance.collection('menu_items');


  //Get All menu items
  Stream<List<MenuItem>> get getAllMenuItems {
    return menuItemCollection.snapshots().map(_menuItemListFromSnapshot);
  }

  List<MenuItem> _menuItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MenuItem(
          id: doc.id,
          name: doc['name'],
          description: doc['description'],
          price: doc['price'],
          image: doc['image']);
    }).toList();
  }
}
