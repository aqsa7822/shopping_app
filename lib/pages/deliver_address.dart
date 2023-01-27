import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/order_page.dart';
import 'package:shopping_app/widgets/widgets.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../helpers/helper_functions.dart';

class DeliveryAddress extends StatefulWidget {
  String fruitName;
  double totalPrice;
  int quantity;
  DeliveryAddress(
      {Key? key,
      required this.fruitName,
      required this.totalPrice,
      required this.quantity})
      : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  final _formKey = GlobalKey<FormState>();
  String fullName = "";
  String address = "";
  int phoneNumber = 0;
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void dispose() {
    _phoneNumber.dispose();
    _fullName.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _random = new Random();
    var orderNumber = _random.nextInt(99999) + 10000;
    return Scaffold(
      appBar: topAppBar(context, "Delivery Address"),
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
                    color: Constants().primaryColor,
                    size: 50,
                  ),
                  Icon(
                    Icons.credit_card,
                    color: Constants().navIconColor,
                    size: 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullName,
                      decoration: inputDecoration("Full Name"),
                      onChanged: (value) {
                        fullName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Full Name!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumber,
                      maxLength: 11,
                      validator: Validators.compose(
                        [
                          Validators.required("Phone Number is requied"),
                          Validators.minLength(
                              11, "Number should be of 11 digits.")
                        ],
                      ),
                      decoration: inputDecoration(
                        "Phone Number",
                      ),
                      onChanged: (value) {
                        phoneNumber = int.parse(value);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _address,
                      keyboardType: TextInputType.streetAddress,
                      decoration: inputDecoration("Address"),
                      onChanged: (value) {
                        address = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Address is required.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    nextScreen(
                        context,
                        OrderPage(
                          fruitName: widget.fruitName,
                          quantity: widget.quantity,
                          totalPrice: widget.totalPrice,
                          receiverName: fullName,
                          receiverPhone: phoneNumber,
                          receiverAddress: address,
                          orderNumber: orderNumber,
                        ));
                  }
                },
                child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}
