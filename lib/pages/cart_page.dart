import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/deliver_address.dart';
import 'package:shopping_app/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  String? fruitName;
  String? imageUrl;
  int? kgQuantity;
  double? price;
  CartPage(
      {Key? key, this.fruitName, this.kgQuantity, this.price, this.imageUrl})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double delivery=Constants().deliveryPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context, "Cart"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  "${widget.imageUrl}",
                  width: 70,
                ),
                Row(
                  children: [
                    Text("${widget.kgQuantity} Kg",
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("\$${widget.price} US",
                        style: const TextStyle(fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Constants().navIconColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.edit_note_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                  const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 36,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.fruitName}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text("\$${widget.price} US", style: const TextStyle(fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text("\$${delivery}US", style: const TextStyle(fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text("\$${widget.price!+delivery} US", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
              ],
            ),
            const SizedBox(height: 25,),
            ElevatedButton(onPressed: (){nextScreen(context, DeliveryAddress(fruitName: widget.fruitName!, totalPrice: widget.price!+delivery, quantity: widget.kgQuantity!));}, child: const Text("Checkout"))
          ],
        ),
      ),
    );
  }
}
