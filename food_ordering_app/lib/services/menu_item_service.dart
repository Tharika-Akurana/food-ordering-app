import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/menu_item.dart';

class MenuItemService {
  final CollectionReference menuItemCollection =
      FirebaseFirestore.instance.collection('menu_items');

  //Create a menu item
  Future createMenuItem(context, MenuItem menuItem) async {
    try {
      await menuItemCollection.add({
        'name': menuItem.name,
        'description': menuItem.description,
        'price': menuItem.price,
        'image': menuItem.image,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Menu item created successfully")));
    } catch (error) {
      log(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in creating menu item")));
    }
  }

  //Update a menu item
  Future updateMenuItem(context, String id, MenuItem menuItem) async {
    try {
      await menuItemCollection.doc(id).update({
        'name': menuItem.name,
        'description': menuItem.description,
        'price': menuItem.price,
        'image': menuItem.image,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Menu item updated successfully")));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in updating menu item")));
    }
  }

  //Delete a menu item
  Future deleteMenuItem(context, String itemId) async {
    try {
      await menuItemCollection.doc(itemId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Menu item deleted successfully")));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in deleting menu item")));
    }
  }

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
