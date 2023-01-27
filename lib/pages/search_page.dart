import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/shop_page.dart';
import 'package:shopping_app/services/fruits_database_service.dart';
import 'package:shopping_app/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../services/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String userName = "";
  String email = "";
  String address = "";
  int phoneNumber = 0;
  String fruitName = "";
  String imageUrl = "";
  bool _isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    gettingUserData();
    super.initState();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailSP().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameSP().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFunctions.getUserAddressSP().then((value) {
      setState(() {
        address = value!;
      });
    });
    await HelperFunctions.getUserPhoneSP().then((value) {
      setState(() {
        debugPrint("${value}");
        phoneNumber = value!;
        debugPrint("$phoneNumber");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            bestFruitShopRow(context, email, userName, address, phoneNumber),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 20, top: 0, bottom: 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      fruitName = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    splashRadius: 20,
                    onPressed: () {
                      search();
                    },
                    icon: Icon(
                      Icons.search,
                      color: Constants().primaryColor,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: hasUserSearched
                  ? fruitCard()
                  : Center(child: Container(child: Text("No Fruit!"),)),
            ),
          ],
        ),
      ),
    );
  }

  search() async {
    debugPrint("HI");
    if (fruitName.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await FruitsDatabaseService().SearchByName(fruitName).then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          _isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  Widget fruitCard() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot!.docs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            nextScreen(
                context,
                ShopFruit(
                  fruitName: fruitName,
                  fruitPrice: searchSnapshot!.docs[index]['Price'],
                  ImageUrl: searchSnapshot!.docs[index]['ImageUrl'],
                ));
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.network(
                    searchSnapshot!.docs[index]['ImageUrl'],
                    width: 80,
                    height: 80,
                  ),
                  Text(
                    fruitName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$${searchSnapshot!.docs[index]['Price']} US",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
