import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar(context, "Cart"),
      body: Container(
        child: const Text("cart page"),
      ),
    );
  }
}
