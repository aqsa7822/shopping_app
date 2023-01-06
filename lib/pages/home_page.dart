import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/helpers/helper_functions.dart';
import 'package:shopping_app/models/fruit_model.dart';
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
    await FruitsDatabaseService().getFruitsData().then((snapshot) {
      setState(() {
        fruitStream = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            bestFruitShopRow(context, email, userName, address, phoneNumber),
            SizedBox(
              height: 20,
            ),
            searchBar(context),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: fruitsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget fruitCard(int fruitPrice, String imageUrl, String fruitName) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.network(imageUrl),
            Text(
              fruitName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${fruitPrice}",
              style: TextStyle(fontSize: 14),
            ),
          ],
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return fruitCard(snapshot.data["Price"],
                            snapshot.data["ImageUrl"], snapshot.data["Name"]);
                      },
                      itemCount: snapshot.data.length),
                ],
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
