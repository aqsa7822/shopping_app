import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/models/fruit_model.dart';

class FruitsDatabaseService {
  final CollectionReference fruitCollection=FirebaseFirestore.instance.collection("fruits");

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
  getFruitsData()async{
    return await fruitCollection.snapshots();
  }
}
