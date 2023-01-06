import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/auth/login_page.dart';
import 'package:shopping_app/pages/profile.dart';
import 'package:shopping_app/widgets/widgets.dart';

import '../helpers/helper_functions.dart';
import '../services/auth_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String userName = "";
  String email = "";
  String address = "";
  int phoneNumber = 0;
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
        debugPrint("${phoneNumber}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar(context, "Setting"),
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                nextScreen(
                    context,
                    ProfilePage(
                        email: email,
                        name: userName,
                        address: address,
                        phoneNumber: phoneNumber));
              },
              child: fieldContainer(context, "Your Account",
                  Constants().fieldColor, Colors.grey)),
          SizedBox(
            height: 15,
          ),
          fieldContainer(context, "Your Order", Constants().fieldColor,
              Colors.grey),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              child: fieldContainer(
                  context, "Sign Out", Constants().signOutColor, Colors.white)),
        ],
      ),
    ));
  }
}
