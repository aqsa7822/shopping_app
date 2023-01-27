import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/profile.dart';
import 'package:shopping_app/pages/search_page.dart';
import 'package:shopping_app/services/fruits_database_service.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 12),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: "Ok",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

Widget fieldContainer(context, String text, Color color, Color textColor) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: textColor),
      textAlign: TextAlign.left,
    ),
  );
}

Widget bestFruitShopRow(
    context, String email, String name, String address, int phoneNumber) {
  return Row(
    children: [
      Expanded(
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Image.asset(
            "assets/logo.png",
            width: 30,
          ),
          title: const Text(
            "BestFruitShop",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          nextScreen(
              context,
              ProfilePage(
                  email: email,
                  name: name,
                  address: address,
                  phoneNumber: phoneNumber));
        },
        child: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 15,
          backgroundImage: AssetImage("assets/user.png"),
        ),
      ),
    ],
  );
}

AppBar topAppBar(context, String title) {
  return AppBar(
    centerTitle: true,
    foregroundColor: Constants().primaryColor,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(fontSize: 20, color: Constants().primaryColor),
    ),
    actions: [
      IconButton(
        onPressed: () {
          nextScreen(context, const SearchPage());
        },
        icon: Icon(
          Icons.search,
          color: Constants().primaryColor,
        ),
      ),
    ],
  );
}


InputDecoration inputDecoration(String hintText){
  return InputDecoration(
    fillColor: Constants().fieldColor,
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        )),
    hintText: hintText,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
  );
}
