import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/widgets/widgets.dart';

class ShopFruit extends StatefulWidget {
  String ImageUrl;
  String fruitName;
  double fruitPrice;
  ShopFruit(
      {Key? key,
      required this.fruitName,
      required this.fruitPrice,
      required this.ImageUrl})
      : super(key: key);

  @override
  State<ShopFruit> createState() => _ShopFruitState();
}

class _ShopFruitState extends State<ShopFruit> {
  int kgQuantity = 1;
  double totalPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    totalPrice = kgQuantity * widget.fruitPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context, "Shop"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.network(widget.ImageUrl),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.fruitName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (kgQuantity > 1) {
                        setState(() {
                          kgQuantity = kgQuantity - 1;
                          totalPrice = widget.fruitPrice * kgQuantity;
                        });
                      }
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Constants().primaryColor,
                    ),
                  ),
                  Text(
                    "${kgQuantity}",
                    style: TextStyle(
                        color: Constants().primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "kg",
                    style: TextStyle(
                        color: Constants().primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        kgQuantity = kgQuantity + 1;
                        totalPrice = widget.fruitPrice * kgQuantity;
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: Constants().primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "\$${totalPrice} US",
              style: TextStyle(
                  fontSize: 22,
                  color: Constants().primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  nextScreen(
                      context,
                      CartPage(
                        fruitName: widget.fruitName,
                        kgQuantity: kgQuantity,
                        price: totalPrice,
                        imageUrl: widget.ImageUrl,
                      ));
                },
                child: Text(
                  "Add To Cart",
                ))
          ],
        ),
      ),
    );
  }
}
