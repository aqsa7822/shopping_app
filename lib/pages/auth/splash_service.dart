import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/helpers/helper_functions.dart';
import 'package:shopping_app/pages/auth/login_page.dart';
import 'package:shopping_app/pages/home_page.dart';
import 'package:shopping_app/widgets/widgets.dart';

import '../home.dart';

class SplashService {
  void isLogin(BuildContext context) async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value == true && FirebaseAuth.instance.currentUser !=null) {
        Timer(const Duration(seconds: 3),
            () => nextScreenReplace(context, const Home()));
      } else {
        Timer(const Duration(seconds: 3),
            () => nextScreenReplace(context, const LoginPage()));
      }
    });
  }
}
