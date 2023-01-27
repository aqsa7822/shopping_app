import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/order_confirmation.dart';
import 'package:shopping_app/services/fruits_database_service.dart';
import 'package:shopping_app/widgets/widgets.dart';

import '../constants/constants.dart';

class OrderPage extends StatefulWidget {
  String fruitName;
  int quantity;
  double totalPrice;
  String receiverName;
  String receiverAddress;
  int receiverPhone;
  int orderNumber;
  OrderPage(
      {Key? key,
      required this.fruitName,
      required this.quantity,
      required this.totalPrice,
      required this.receiverName,
      required this.receiverPhone,
      required this.receiverAddress,
      required this.orderNumber})
      : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? userId;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getUserId();
    super.initState();
  }

  getUserId() {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Constants().primaryColor,
            ),
          )
        : Scaffold(
            appBar: topAppBar(context, "Order"),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 2,
                        offset: Offset(6, 2),
                      )
                    ]),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Constants().navIconColor,
                          size: 50,
                        ),
                        Icon(
                          Icons.credit_card,
                          color: Constants().primaryColor,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                    decoration: BoxDecoration(
                      color: Constants().fieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Constants().primaryColor,
                          size: 100,
                        ),
                        Text(
                          "Add Card",
                          style: TextStyle(
                              color: Constants().primaryColor, fontSize: 26),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        order();
                      },
                      child: Text("Order")),
                ],
              ),
            ),
          );
  }

  Future order() async {
    setState(() {
      _isLoading = true;
    });
    await FruitsDatabaseService()
        .createOrder(
            widget.receiverName,
            widget.receiverAddress,
            widget.receiverPhone,
            widget.fruitName,
            userId!,
            widget.quantity,
            widget.totalPrice,
            widget.orderNumber)
        .then((value) {
      nextScreenReplace(context, OrderConfirmation(orderNumber: widget.orderNumber));
    }).onError((error, stackTrace) {
      showSnackbar(context, Colors.red, "Order Failed");
      _isLoading = false;
    });
  }
}
