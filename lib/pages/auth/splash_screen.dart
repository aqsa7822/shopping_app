import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/auth/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashService splashService = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Shopping App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Constants().primaryColor),
                ),
                Image.asset(
                  "assets/apple.png",
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 300,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Loading...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  color: Constants().primaryColor,
                ),
              ],
            ),
          ),
        ));
  }
}
