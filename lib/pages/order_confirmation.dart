import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/widgets/widgets.dart';

class OrderConfirmation extends StatelessWidget {
  int orderNumber;
  OrderConfirmation({Key? key, required this.orderNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          nextScreenReplace(context, Home());
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Image.asset(
                  "assets/order.png",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Order Place \n Your Order Number is #${orderNumber}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
