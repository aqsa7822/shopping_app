import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/auth/splash_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp();
    }
  } catch (error) {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: FirebaseOptions(
        apiKey: Constants().apiKey,
        appId: Constants().appId,
        messagingSenderId: Constants().messagingSenderId,
        projectId: Constants().projectId,
        authDomain: Constants().authDomain,
        measurementId: Constants().measurementId,
        storageBucket: Constants().storageBucket,
      ));
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        // ---------------------------------------------------------------Bottom Navigation Bar Theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Constants().primaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 30,
          unselectedItemColor: Constants().navIconColor,
        ),

        // ------------------------------------------------------------------Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: Constants().primaryColor,
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
        )),

        // ---------------------------------------------------------------------Card Theme
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
        ),

        primaryColor: Constants().primaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}
