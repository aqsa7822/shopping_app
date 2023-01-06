import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/helpers/helper_functions.dart';
import 'package:shopping_app/pages/auth/login_page.dart';
import 'package:shopping_app/pages/home_page.dart';
import '../../constants/constants.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../widgets/widgets.dart';
import '../home.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String fullName="";
  String email = "";
  String password = "";
  int phoneNumber=0;
  String address="";
  String confirmPassword = "";
  final TextEditingController _phoneNumber=TextEditingController();
  final TextEditingController _fullName=TextEditingController();
  final TextEditingController _address=TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  void dispose(){
    _phoneNumber.dispose();
    _fullName.dispose();
    _passwordController.dispose();
    _address.dispose();
    _emailController.dispose();
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
                        "Create Account",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        controller: _fullName,
                        decoration: inputDecoration("Full Name"),
                        onChanged: (value) {
                          fullName = value;
                        },
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter Full Name!";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumber,
                        maxLength: 11,
                        validator: Validators.compose(
                          [
                            Validators.required("Phone Number is requied"),
                            Validators.minLength(
                                11, "Number should be of 11 digits.")
                          ],
                        ),
                        decoration: inputDecoration("Phone Number",),
                        onChanged: (value) {
                          phoneNumber=int.parse(value);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _address,
                        keyboardType: TextInputType.streetAddress,
                        decoration: inputDecoration("Address"),
                        onChanged: (value) {
                          address=value;
                        },
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Address is required.";
                          }
                          else{
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 15,
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
                        height: 15,
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
                      TextFormField(
                        obscureText: true,
                        decoration: inputDecoration("Confirm Password"),
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        validator: (value) {
                          if (value != password) {
                            return "Confirmation Password should match with password.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        child: const Text(
                          "Sign Up",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "Already have an Account? ",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                  text: "Sign In Here...",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextScreen(context, const LoginPage());
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

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .signUpWithEmailAndPassword(email, password, fullName, address, phoneNumber)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSP(email);
          await HelperFunctions.saveUserNameSP(fullName);
          await HelperFunctions.saveUserAddressSP(address);
          await HelperFunctions.saveUserPhoneSP(phoneNumber);

          nextScreenReplace(context, const Home());
        } else {
          setState(() {
            _isLoading = false;
          });
          showSnackbar(context, Colors.red, value);
        }
      });
    }
  }
}
