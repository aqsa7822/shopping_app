import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/pages/auth/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopping_app/pages/notification_page.dart';
import 'package:shopping_app/provider/theme_changer_provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(),
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping App',
          themeMode: themeChanger.themeMode,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
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
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
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
              color: Colors.black,
              shadowColor: Constants().primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
            ),
            indicatorColor: Constants().primaryColor,

            primaryColor: Constants().primaryColor,
          ),
          home: const SplashScreen(),
          // home: const SplashScreen(),
        );
      }),
    );
  }
}
