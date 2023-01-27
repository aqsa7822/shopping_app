import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/helpers/helper_functions.dart';

class DatabaseService {
  String? userId;

  DatabaseService({this.userId});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // saving user data
  Future savingUserData(
      String email, String name, String address, int phone) async {
    return await userCollection.doc(userId).set({
      "userName": name,
      "email": email,
      "imageUrl": "",
      "phoneNumber": phone,
      "userId": userId,
      "address": address,
      "token": "",
      "orders":[],
      "createdAt": Timestamp.now(),
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }
  getUserOrders()async{
    return userCollection.doc(userId).get();
  }
}
