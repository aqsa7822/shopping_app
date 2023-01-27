import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/models/fruit_model.dart';
import 'package:shopping_app/services/database_service.dart';

class FruitsDatabaseService {

  final CollectionReference fruitCollection =
      FirebaseFirestore.instance.collection("fruits");
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection("orders");

  FruitModel? fruitModel;
  List<FruitModel> fruits = [];

  fruitModels(QueryDocumentSnapshot element) {
    fruitModel = FruitModel(
      fruitName: element.get("Name"),
      fruitPrice: element.get("Price"),
      imageUrl: element.get("ImageUrl"),
    );
    fruits.add(fruitModel!);
  }

  List<FruitModel> allFruitsList = [];

  fetchAllFruits() async {
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("fruits").get();
    value.docs.forEach((element) {
      fruitModels(element);
      allFruitsList.add(fruitModel!);
    });
    return fruits;
  }

  getOrderData(String docId) async {
    var documentSnapshot=await orderCollection.doc(docId).get();
    return documentSnapshot;
  }

  Stream<List> getFruitsData() {
    return fruitCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  SearchByName(String name){
    return fruitCollection.where('Name', isEqualTo: name).get();
  }

  // create order
  Future createOrder(
      String fullName,
      String deliveryAddress,
      int phoneNumber,
      String fruitName,
      String userId,
      int kgQuantity,
      double totalPrice,
      int orderNumber) async {
    DocumentReference orderDocumentReference = await orderCollection.add({
      "deliveryFullName": fullName,
      "deliveryAddress": deliveryAddress,
      "deliveryPhone": phoneNumber,
      "orderId": "",
      "totalCost": totalPrice,
      "Quantity (kg)": kgQuantity,
      "orderNumber": orderNumber,
      "orderedProducts": "${userId}_$fruitName",
    });
    await orderDocumentReference.update({
      "orderId": orderDocumentReference.id
    });
    DocumentReference userDocumentReference =
        await DatabaseService(userId: userId).userCollection.doc(userId);
    return await userDocumentReference.update({
      "orders": FieldValue.arrayUnion(["${orderDocumentReference.id}"])
    });
  }
}
