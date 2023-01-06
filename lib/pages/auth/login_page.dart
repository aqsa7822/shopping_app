import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/helpers/helper_functions.dart';
import 'package:shopping_app/pages/auth/signup_page.dart';
import 'package:shopping_app/pages/home_page.dart';
import 'package:shopping_app/services/auth_service.dart';
import 'package:shopping_app/widgets/widgets.dart';
import 'package:shopping_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/constants.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Constants().primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: inputDecoration("Email"),
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Please Enter A Valid Email";
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: inputDecoration("Password"),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "Don't have an Account? ",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                  text: "Sign Up Here...",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextScreen(context, const SignUpPage());
                                    },
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Constants().primaryColor,
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService
          .loginWithUserEmailAndPassword(email, password)
          .then((value) async{
        if (value == true) {
          QuerySnapshot snapshot= await DatabaseService(userId: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);

          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserNameSP(snapshot.docs[0]['userName']);
          await HelperFunctions.saveUserEmailSP(email);
          await HelperFunctions.saveUserPhoneSP(snapshot.docs[0]['phoneNumber']);
          await HelperFunctions.saveUserAddressSP(snapshot.docs[0]['address']);
          nextScreenReplace(context, const Home());
        } else {
          setState(() {
            _isLoading=false;
          });
          showSnackbar(context, Colors.red, value);

        }
      });
    }
  }
}
