import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/services/database_service.dart';
import 'package:shopping_app/services/fruits_database_service.dart';
import 'package:shopping_app/widgets/widgets.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List? orders;
  int? quantity;
  String? deliverAddress;
  String? receiverName;
  int? receiverNum;
  int? orderNum;
  String? fruitName;
  // QuerySnapshot? snapshot;

  @override
  void initState() {
    // TODO: implement initState
    getOrders();
    super.initState();
  }

  getOrders() {
    DatabaseService(userId: FirebaseAuth.instance.currentUser!.uid)
        .getUserOrders()
        .then((snapshots) {
      setState(() {
        orders = snapshots.data()['orders'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context, "My Orders"),
      body: displayOrders(),
    );
  }

  // Future getValues(String orderId) async {
  //
  // }

  Future<Widget> OrderTile(String orderId) async {
    await FruitsDatabaseService().getOrderData(orderId).then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();
        receiverName = data?['deliveryFullName'].toString();
      }
    });
    debugPrint(receiverName);
    return Text(receiverName!);
  }

  Widget noOrderTile() {
    return Center(
      child: Text("No Orders"),
    );
  }

  displayOrders() {
    return ListView.builder(
        itemCount: orders?.length,
        itemBuilder: (BuildContext context, int index) {
          return OrderTile(orders![index]) as Widget;
        });
  }
}
