import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/pages/auth/login_page.dart';
import 'package:shopping_app/pages/my_orders.dart';
import 'package:shopping_app/pages/profile.dart';
import 'package:shopping_app/widgets/widgets.dart';

import '../helpers/helper_functions.dart';
import '../provider/theme_changer_provider.dart';
import '../services/auth_service.dart';
import 'package:shopping_app/main.dart';

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
        phoneNumber = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger =Provider.of<ThemeChanger>(context);
    return Scaffold(
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
              GestureDetector(
                onTap: () {
                  nextScreen(context, MyOrders());
                },
                child: fieldContainer(
                    context, "Your Order", Constants().fieldColor, Colors.grey),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Constants().fieldColor),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Switch to Dark Theme",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Switch(
                        value: themeChanger.dark,
                        splashRadius: 3,
                        activeColor: Constants().primaryColor,
                        onChanged: (bool val) {
                          if(val==true){
                            themeChanger.setTheme(ThemeMode.dark);
                          }
                          else{
                            themeChanger.setTheme(ThemeMode.light);
                          }
                        }),
                  ],
                ),
              ),
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
                  child: fieldContainer(context, "Sign Out",
                      Constants().signOutColor, Colors.white)),
            ],
          ),
        ));
  }
}
