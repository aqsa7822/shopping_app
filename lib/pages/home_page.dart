import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/helpers/helper_functions.dart';
import 'package:shopping_app/models/fruit_model.dart';
import 'package:shopping_app/pages/shop_page.dart';
import 'package:shopping_app/services/auth_service.dart';
import 'package:shopping_app/services/fruits_database_service.dart';
import 'package:shopping_app/widgets/widgets.dart';

import '../services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  String address = "";
  int phoneNumber = 0;
  Stream? fruitStream;
  String fruitName="";
  bool hasUserSearched=false;
  QuerySnapshot? searchSnapshot;
  bool _isLoading=false;
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
        phoneNumber = value!;
      });
    });
    fruitStream = await FruitsDatabaseService().getFruitsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
              height: 10,
            ),
            Expanded(child: hasUserSearched
                ? searchedFruitCard()
                : fruitsList(),),
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

  Widget searchedFruitCard() {
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
    );}



  Widget fruitCard(int fruitPrice, String imageUrl, String fruitName) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ShopFruit(fruitName: fruitName,fruitPrice: fruitPrice.toDouble(),ImageUrl: imageUrl,));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(imageUrl, width: 80,height: 80,),
              Text(
                fruitName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "\$${fruitPrice} US",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fruitsList() {
    return StreamBuilder(
        stream: fruitStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: List.generate(snapshot.data.length, (index){

                  return fruitCard(snapshot.data[index]["Price"], snapshot.data[index]["ImageUrl"], snapshot.data[index]["Name"]);
                }),
              );
            } else {
              return Center(
                child: Text("Error!"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Constants().primaryColor,
              ),
            );
          }
        });
  }
}
