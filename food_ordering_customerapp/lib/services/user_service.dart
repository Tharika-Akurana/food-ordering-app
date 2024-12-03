import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  User user = FirebaseAuth.instance.currentUser!;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future createUser(context, userName, mobile, address) async {
    try {
      //Create a user document in the users collection with the user id
      await userCollection.doc(user.uid).set({
        "uid": user.uid,
        "userName": userName,
        "mobile": mobile,
        "address": address,
        //"imageUrl": "www.adsf.com/asdf"
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User details saved successfully")));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in creating the user!")));
    }
  }

  //Fetch the loged in users details

  Future fetchUserDetails() async {
    User user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    log(userDoc.data().toString());
    return userDoc.data();
  }


}
